/* ENTORNO */
/* Indicamos la base de datos sobre la que queremos trabajar */
use ventasParticulares

/* Limpiamos el entorno de cualquier ejecucion anterior*/
db.items.drop()

/* creamos indice 2d para la localizacion*/
db.items.ensureIndex({ localizacion: "2d" });

/* Creacion de la base de datos e insercion de documentos en la coleccion Items */
db.items.insert({
  descripcion: "Mando xBox negro",
  fecha: new Date ("2015, 3, 21"),
  precio: 10,
  tags: ["consolas", "xbox", "entretenimiento"],
  vendedor: {email: "pperez@gmail.com", psw: "pperez"},
  localizacion: {longitude: 37.743671, latitude: -2.552276},
  estado: "disponible",
  contraofertas: [
    {email: "llopez@gmail.com", psw: "llopez", oferta: 8, fecha: new Date("2015, 4, 2")},
    {email: "ggomez@gmail.com", psw: "ggomez", oferta: 7, fecha: new Date("2015, 4, 13")}
  ]
})

db.items.insert({
  descripcion: "Mando Wii Mario",
  fecha: new Date ("2013, 10, 2"),
  precio: 8,
  tags: ["consolas", "wii", "entretenimiento"], 
  vendedor: {email: "ffernandez@gmail.com", psw: "ffernandez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "vendido",
  comprador: {email: "llopez@gmail.com", psw: "llopez"},
  contraofertas: [
    {email: "llopez@gmail.com", psw: "llopez", oferta: 7, fecha: new Date("2013, 10, 20")},
    {email: "aalonso@gmail.com", psw: "ggomez", oferta: 5, fecha: new Date("2013, 10, 19")}
  ]
})

db.items.insert({
  descripcion: "Thermomix",
  fecha: new Date ("2015, 5, 2"),
  precio: 80,
  tags: ["robot cocina", "menaje"], 
  vendedor: {email: "ffernandez@gmail.com", psw: "ffernandez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Iphone 4G",
  fecha: new Date ("2014, 2, 2"),
  precio: 200,
  tags: ["teléfono móvil"], 
  vendedor: {email: "ggomez@gmail.com", psw: "ggomez"},
  localizacion: {longitude: 37.743671, latitude: -2.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Iphone 4",
  fecha: new Date ("2013, 12, 22"),
  precio: 150,
  tags: ["teléfono móvil"], 
  vendedor: {email: "llopez@gmail.com", psw: "llopez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Thermomix",
  fecha: new Date ("2011, 6, 22"),
  precio: 20,
  tags: ["robot cocina", "menaje"], 
  vendedor: {email: "aalvarez@gmail.com", psw: "aalvarez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Cuberteria Plata",
  fecha: new Date ("2011, 6, 22"),
  precio: 12,
  tags: ["cocina", "menaje"], 
  vendedor: {email: "aalvarez@gmail.com", psw: "aalvarez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "vendido"
})

db.items.insert({
  descripcion: "Nokia N96",
  fecha: new Date ("2011, 12, 22"),
  precio: 35,
  tags: ["teléfono móvil"], 
  vendedor: {email: "bbenitez@gmail.com", psw: "bbenitez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Nokia N95",
  fecha: new Date ("2011, 12, 22"),
  precio: 30,
  tags: ["teléfono móvil"], 
  vendedor: {email: "bbenitez@gmail.com", psw: "bbenitez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "disponible"
})

db.items.insert({
  descripcion: "Nokia N95",
  fecha: new Date ("2011, 2, 3"),
  precio: 30,
  tags: ["teléfono móvil"], 
  vendedor: {email: "bbenitez@gmail.com", psw: "bbenitez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "vendido"
})

db.items.insert({
  descripcion: "Nokia N95",
  fecha: new Date ("2012, 1, 22"),
  precio: 30,
  tags: ["teléfono móvil"], 
  vendedor: {email: "bbenitez@gmail.com", psw: "bbenitez"},
  localizacion: {longitude: 38.743671, latitude: -10.552276},
  estado: "vendido"
})

/* EJERCICIOS */
/* Actualizar la colección “ítems” para hacer una contraoferta al primer producto disponible que esté etiquetado como “teléfono móvil” y que haya sido puesto en venta con posterioridad al 1/1/2014. */
db.items.update(
	{
		tags:"teléfono móvil", 
		fecha: 
		{
			$gt : new Date("2014, 1, 2")
		}
	},
	{
		$addToSet: 
		{
			contraofertas:
			{
				email: "ggomez@gmail.com", 
				psw: "ggomez", 
				oferta: 100, 
				fecha: new Date("2015, 6, 4") 
			}
		}
	}
)

/* Actualizar la colección “ítems” para modificar el estado de todos los productos puestos en venta antes de 1/1/2012 y cuyo estado sea disponible. El nuevo estado pasará a ser descatalogado. */
db.items.update(
	{
		fecha: 
		{
			$lt : new Date("2012, 1, 2")
		},
		estado: "disponible"
	},
	{
		$set:
		{
			estado: "descatalogado"
		}
	},
	{ 
		multi: true
	}
)

/* Recuperar la descripción y precio de todos los productos etiquetados como “entretenimiento”, cuyo estado sea disponible y que estén en venta en un punto cercano al nuestro (+- 1000 mts.) */
lugar = [ 37.745609,-2.5461388] // Suponemos que estamos aqui, esto esta a unos 800 metros aprox
max = 1/111.12 // Convertimos los grados a kilometros. Si bajamos a 700 metros o 0.7 km, vemos que ya no estamos dentro del radio 

db.items.find(
	{
		tags:"entretenimiento", 
		estado:"disponible", 
		localizacion: 
		{ 
			$near : lugar , 
			$maxDistance: max
		}
	},
	{
		_id:0,
		descripcion:1,
		precio:1
	}
)
			
/* Averiguar el número de ítems disponibles que estén etiquetados como “teléfono móvil” y que cuesten menos de 60€. */
db.items.count(
	{ 
		tags:"teléfono móvil", 
		estado:"disponible", 
		precio:
		{
			$lt:60
		}
	}
)
			
/* Eliminar los registros cuyo estado sea “vendido” y que hubieran sido puestos a la venta antes del 1/1/2012. */
db.items.remove(
	{
		estado:"vendido",
		fecha: 
		{
			$lt : new Date("2012, 1, 2")
		}
	}
)










