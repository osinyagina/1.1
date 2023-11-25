from sqlalchemy import create_engine, text
import os

def sql_exec(sql, user, password, host, port, db, engine=None):
    db_uri = f'postgresql://{user}:{password}@{host}:{port}/{db}'
    engine = create_engine(os.environ.get(db_uri))
    with engine.connect() as conn:
        sql = text(sql)
        conn.execute(sql)
    engine.dispose()
