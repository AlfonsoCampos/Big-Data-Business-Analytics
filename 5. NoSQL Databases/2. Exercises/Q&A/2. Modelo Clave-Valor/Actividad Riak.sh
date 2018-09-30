echo ""
echo "Actividad Clave-Valor con Riak - Master CIFF - Alfonso Campos"
echo ""

sleep 5

echo "Apartado A"
echo "Se ha optado por un diseño basado en 2 buckets, uno para Tweets y otro para Usuarios."
echo "Este diseño resulta util para responder los patrones de uso."
echo "La clave de los Bucket es en ambos casos una secuencia numerica a modo de identificar unico"
echo "Se han definido una serie de links entre los Usuarios y los Tweets que nos permitiran responder"
echo " al patron de uso de averiguar los Tweets de un usuario particular."
echo ""

sleep 20

echo "Apartado B"
echo "Dados los requisitos para la aplicacion en terminos del teorema CAP, parece aconsejable utilizar: "
echo "AP en Tweets, por lo que Riak seria aconsejable, dado que ademas no se realizan modificaciones."
echo "CP en Usuarios, por lo que aqui seria mas aconsejable utilizar MongoDB configurado para ofrecer CP."
echo ""

sleep 15

echo "Apartado C"
echo "A continuacion se ejecutan las sentencias de creacion/insercion: "
echo ""

sleep 5

# Tweets
curl -X PUT http://localhost:8098/riak/tweet/0001 \
-H "Content-Type: application/json" \
-d ' {text:"Riak se sale!", createdAt"2012-10-18 09:37:01", app:"Tweeter Yeah!", lattitude:40.4, longitude:-3.6833333}'

curl -X PUT http://localhost:8098/riak/tweet/0002 \
-H "Content-Type: application/json" \
-d ' {text:"+1", createdAt"2012-10-18 09:39:11", app:"Tweeter Yeah!", lattitude:40.4, longitude:-3.6833333, retweet:0001}'

curl -X PUT http://localhost:8098/riak/tweet/0003 \
-H "Content-Type: application/json" \
-d ' {text:"=)", createdAt"2012-10-19 19:47:31", app:"Tweeter Fun", lattitude:41.390205, longitude:2.154007, retweet:0001}'

curl -X PUT http://localhost:8098/riak/tweet/0004 \
-H "Content-Type: application/json" \
-d ' {text:"Mola, pero Cassandra se sale mas!", createdAt"2012-10-20 12:23:32", app:"Tweeter Yeah!", lattitude:40.4, longitude:-3.6833333, reply:0001}'

curl -X PUT http://localhost:8098/riak/tweet/0005 \
-H "Content-Type: application/json" \
-d ' {text:"Polseres Vermelles", createdAt"2013-04-01 15:27:01", app:"Tweeter Fun!", lattitude:41.390205, longitude:2.154007}'

curl -X PUT http://localhost:8098/riak/tweet/0006 \
-H "Content-Type: application/json" \
-d ' {text:"Últim episodi!!", createdAt"2013-04-01 19:23:01", app:"Tweeter Yeah!", lattitude:41.390205, longitude:2.154007, retweet:0005}'

# Users
curl -X PUT http://localhost:8098/riak/user/0001 \
-H "Content-Type: application/json" \
-d ' {alias:"Ikos", name:"Alfonso Campos"}'

curl -X PUT http://localhost:8098/riak/user/0002 \
-H "Content-Type: application/json" \
-d ' {alias:"Yoly", name:"Yolanda Hernandez"}'

curl -X PUT http://localhost:8098/riak/user/0003 \
-H "Content-Type: application/json" \
-d ' {alias:"Jordi", name:"Jordi Nin"}'

curl -X PUT http://localhost:8098/riak/user/0004 \
-H "Content-Type: application/json" \
-d ' {alias:"Albert", name:"Albert Pont"}'

# Links
curl -v -X PUT http://localhost:8098/riak/user/0001 \
-H "Content-Type: application/json" \
-H 'Link: </riak/tweet/0001>; riaktag="tweets"'

curl -v -X PUT http://localhost:8098/riak/user/0002 \
-H "Content-Type: application/json" \
-H 'Link: </riak/tweet/0002>; riaktag="tweets"' \
-H 'Link: </riak/tweet/0004>; riaktag="tweets"'

curl -v -X PUT http://localhost:8098/riak/user/0003 \
-H "Content-Type: application/json" \
-H 'Link: </riak/tweet/0003>; riaktag="tweets"' \
-H 'Link: </riak/tweet/0006>; riaktag="tweets"'

curl -v -X PUT http://localhost:8098/riak/user/0004 \
-H "Content-Type: application/json" \
-H 'Link: </riak/tweet/0005>; riaktag="tweets"'

echo ""
echo "A continuacion se ejecutan las querys para el caso de la consulta de un Tweet por clave"
echo ""

sleep 5

# Querys
curl -v -X GET http://localhost:8098/riak/tweet/0004 #Consulta de Tweet por clave

echo ""
echo " y todos los Tweets de un Usuario determinado: "
echo ""

sleep 15

curl -v -X GET http://localhost:8098/riak/user/0003/tweet,tweets,0/

echo ""
echo "Eso es todo! Saludos"