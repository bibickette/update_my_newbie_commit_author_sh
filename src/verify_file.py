import sys

# print(sys.argv)
file = sys.argv[1]

# 1. check if .py
if not file.endswith(".py"):
    print(f"Error : '{file}' is not a Python file (.py)")
    sys.exit(1)


ns = {}
# 2. check if python file and load it
try:
    exec(open(file).read(), ns)
except Exception as e:
    print("Python Error:", e)
    sys.exit(1)

# 3. check required variables
required = ["BAD_EMAILS", "BAD_NAMES", "RIGHT_NAME", "RIGHT_EMAIL"]
for var in required:
    if var not in ns:
        print(f"Error : missing variable: {var}")
        sys.exit(1)
        
# print(ns.keys())
# 4. check no other variables
allowed = set(required + ["__builtins__"])
for var in ns:
    if var not in allowed:
        print(f"Error : bad variable: {var}")
        sys.exit(1)
        
# 5. check types and lengths for BAD_EMAILS and BAD_NAMES
if not isinstance(ns["RIGHT_NAME"], list) or len(ns["RIGHT_NAME"]) != 1:
    print("Error: RIGHT_NAME must be a list with exactly 1 element and between []")
    sys.exit(1)

if not isinstance(ns["RIGHT_EMAIL"], list) or len(ns["RIGHT_EMAIL"]) != 1:
    print("Error: RIGHT_EMAIL must be a list with exactly 1 element and between []")
    sys.exit(1)
    
print("Config File OK")

# function check if the argument script file is a .py and have the right variables and no others