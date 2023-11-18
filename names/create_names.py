
#!/usr/bin/env python
import io
import os
import sys

if len(sys.argv) < 3 or len(sys.argv) > 4:
   print("create_names.py <output> <default names> <optional custom names>")
   sys.exit()

output_asm = sys.argv[1]
default_txt = sys.argv[2]
custom_txt = ""
if len(sys.argv) > 3:
   custom_txt = sys.argv[3]

f_default = io.open(os.path.join(os.path.dirname(os.path.realpath(__file__)), default_txt), "r")
default_lines = f_default.readlines()
f_default.close()

custom_lines = []
if custom_txt != "":
   custom_filepath = os.path.join(os.path.dirname(os.path.realpath(__file__)), custom_txt)
   if os.path.isfile(custom_filepath):
      f_custom = io.open(custom_filepath, "r")
      custom_lines = f_custom.readlines()
      f_custom.close()

names = {}

for line in default_lines:
   parts = line.split('=')
   if len(parts) == 2:
      room_id = parts[0].strip()
      if len(room_id) == 4:
         names[room_id] = parts[1].strip()

for line in custom_lines:
   parts = line.split('=')
   if len(parts) == 2:
      room_id = parts[0].strip()
      if room_id in names:
         names[room_id] = parts[1].strip()

f_output = io.open(os.path.join(os.path.dirname(os.path.realpath(__file__)), output_asm), "w", newline='\n')
f_output.write("\n; ---------------")
f_output.write("\n; Room Names")
f_output.write("\n; (autogenerated)")
f_output.write("\n; ---------------")
f_output.write("\n\norg !ORG_ROOMNAMES+$8000\n")
f_output.write("print pc, \" roomnames start\"\n")
f_output.write("RoomNameTextTable:\n\n")

max_characters = 24
max_roomname_space = max_characters + 2
last_room_id = None
for room_id in sorted(names):
   if last_room_id:
      last_room_end = int(last_room_id, 16) + max_roomname_space
      if last_room_end > int(room_id, 16):
         last_room_end = room_id
      f_output.write("warnpc !ORG_ROOMNAMES+$" + f'{last_room_end:04X}' + "\n\n")
   f_output.write("org !ORG_ROOMNAMES+$" + room_id + "\n")
   f_output.write("db $28, \"" + names[room_id] + "\", $FF\n")
   last_room_id = room_id

if last_room_id:
   last_room_end = int(last_room_id, 16) + max_characters
   f_output.write("warnpc !ORG_ROOMNAMES+$" + f'{last_room_end:04X}' + "\n\n")

f_output.write("print pc, \" roomnames end\"\n\n")
f_output.close()

