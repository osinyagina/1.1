import
from db_utils import sql_exec

def main():
    
    path_to_scripts = sys.argv[1]
    user = sys.argv[2]
    password = sys.argv[3]
    host = sys.argv[4]
    port = sys.argv[5]
    schema = sys.argv[6]
    
    files = os.listdir(path_to_scripts)
    file_paths = [Path(path_to_scripts, f) for f in files]
    file_paths.sort(key=lambda x: x.name)
    
    for fp in file_paths:
        sql = fp.read_text()
        sql_exec(sql, user, password, host, port, db)
    
