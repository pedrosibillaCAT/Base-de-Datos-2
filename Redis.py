import redis
from datetime import date
r = redis.Redis(
host='localhost',
port=6257)
print("Bienvenido a su listado de tareas del dia")
comida = 'a'
today = str(date.today())
fecha = 'a'

while comida!="":
    comida = input("Inserte su activad mas reciente o presione enter para salir ")
    if comida == "":
        pass
    else:
        r.lpush(today, comida)
print('Las tareas del dia '+ today+' fueron:')
for a in r.lrange(today, 0, -1):
    print(str(a.decode('utf-8')))

print('Estas son todas las fechas que en las que se guardaron las tareas realizadas: ')
for key in r.scan_iter():
    print(str(key.decode('utf-8')))

while fecha!='':
    fecha=input('Inserte la fecha de la que desea saber que actividad realizo o presione enter para salir ')
    for x in r.lrange(fecha, 0, -1):
        print(str(x.decode('utf-8')))
