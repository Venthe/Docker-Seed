conn = new Mongo();
db = conn.getDB();
print('Current users:');
printjson(db.getUsers());
