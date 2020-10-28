import redis
from datetime import date
r = redis.Redis(
host='localhost',
port=6379)
print("Bienvenido a tu sistema de guardado de alimentos")
comida = 'a'
today = str(date.today())
fecha = 'a'

while comida!="":
    comida = input("Inserte su comida mas reciente o presione enter para salir ")
    if comida == "":
        pass
    else:
        r.lpush(today, comida)
print('Los alimentos del dia '+ today+' fueron:')
for a in r.lrange(today, 0, -1):
    print(str(a.decode('utf-8')))

print('Estas son todas las fechas que en las que se guardaron comidas: ')
for key in r.scan_iter():
    print(str(key.decode('utf-8')))

while fecha!='':
    fecha=input('Inserte la fecha de la que desea saber que comio o presione enter para salir ')
    for x in r.lrange(fecha, 0, -1):
        print(str(x.decode('utf-8')))
