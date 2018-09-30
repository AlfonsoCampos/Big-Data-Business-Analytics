"""
@author: U{Nines Sanguino}
@version: 0.2
@since: 04Sep2015
"""

__version__ = '0.2'
__modified__ = '04Sep2015'
__author__ = 'Nines Sanguino'

##### Changes ##############
# v0.1 ==> basic functions and methods
# ################################

from SPARQLWrapper import SPARQLWrapper, JSON, XML, RDF
import xml.dom.minidom
def getLocalLabel (instancia):
	sparqlSesame = SPARQLWrapper("http://localhost:8080/openrdf-sesame/repositories/SocialNetwork", returnFormat=JSON)
	queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX sn: <http://ciff.curso2015/ontologies/owl/socialNetwork#> SELECT ?label WHERE { sn:" + instancia + " rdfs:label ?label }"
	sparqlSesame.setQuery(queryString)
	sparqlSesame.setReturnFormat(JSON)
	query = sparqlSesame.query()
	#print "La query de getLocalLabel es:"
	#print query
	results = query.convert()
	#print "results de getLocalLabel es:"
	#print results
	lista = []
	
	for result in results["results"]["bindings"]:
		label = result["label"]["value"]
		#if (result["label"].get["xml:lang"]):
		if (result["label"].get("xml:lang")):
			#lang.append(result["label"]["xml:lang"])
			#lang = result["label"]["xml:lang"]
			lista.append((str(label),str(result["label"]["xml:lang"])))
		else:
			lista.append((str(label),None))
	#print "La lista es:"
	#print lista
	return lista


def getDBpediaResource (label, lang, endpoint):
	#print "El lenguaje es:"
	#print lang
	sparqlDBPedia = SPARQLWrapper('http://dbpedia.org/sparql')
	if (lang):
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf:\
		<http://xmlns.com/foaf/0.1/> SELECT ?s ?givenName WHERE { ?s rdfs:label \"" + label + "\"@" + lang + " . ?s rdf:type foaf:Person . ?s foaf:givenName ?givenName } "
	else:
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf:\
		<http://xmlns.com/foaf/0.1/> SELECT ?s ?givenName WHERE { ?s rdfs:label \"" + label + "\" . ?s rdf:type foaf:Person . ?s foaf:givenName ?givenName } "
	
	#print "La query es:"
	#print queryString
	sparqlDBPedia.setQuery(queryString)
	sparqlDBPedia.setReturnFormat(JSON)
	query = sparqlDBPedia.query()
	results = query.convert()
	for result in results["results"]["bindings"]:
		resource = result["s"]["value"]
		givenName = result["givenName"]["value"]
		print "The resource: " + resource
		print "The givenName: " + givenName


def getMDBResource (label, lang, endpoint):
	#print "El lenguaje es:"
	#print lang
	sparqlDBPedia = SPARQLWrapper('http://data.linkedmdb.org/sparql')
	queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> \
		PREFIX dc: <http://purl.org/dc/terms/> \
		PREFIX movie: <http://data.linkedmdb.org/resource/movie/> \
		SELECT ?s WHERE {?s  rdfs:label \"" + label + "\" }"
	
	print "La query es:"
	print queryString
	sparqlDBPedia.setQuery(queryString)
	sparqlDBPedia.setReturnFormat(JSON)
	query = sparqlDBPedia.query()
	results = query.convert()
	for result in results["results"]["bindings"]:
		resource = result["s"]["value"]
		print "The resource: " + resource



def getWebViajeroResource (label, lang, endpoint):
	#print "Empieza getWebViajeroResource"
	#print "La label recibida es: "
	#print label
	#print "El lenguaje es:"
	#if (lang):
	# print lang
	#else:
	# print "None"
	sparqlDBPedia = SPARQLWrapper('http://webenemasuno.linkeddata.es/sparql')
	if (lang):
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf:\
		<http://xmlns.com/foaf/0.1/> SELECT ?s ?periodico WHERE { ?s sioc:title \"" + label + "\"@" + lang + " . ?s rdf:type ?periodico } "
	else:
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf:\
		<http://xmlns.com/foaf/0.1/> SELECT ?s ?periodico WHERE { ?s sioc:title \"" + label + "\" . ?s rdf:type ?periodico } "
	
	print "La query es:"
	print queryString
	sparqlDBPedia.setQuery(queryString)
	sparqlDBPedia.setReturnFormat(JSON)
	query = sparqlDBPedia.query()
	results = query.convert()
	#print "results es:"
	#print results
	for result in results["results"]["bindings"]:
		resource = result["s"]["value"]
		periodico = result["periodico"]["value"]
		print "The resource: " + resource
		print "El periodico: " + periodico


if __name__ == '__main__':
	print "**************"
	print "* instancia 1*"
	print "**************"
	lista = getLocalLabel("instancia1");
	endpoint = 'http://dbpedia.org/sparql';
	for i in lista:
		resource = getDBpediaResource (i[0], i[1], endpoint);

	print "**************"
	print "* instancia 3*"
	print "**************"
	lista = getLocalLabel("instancia3");
	endpoint = 'http://data.linkedmdb.org/sparql';
	for i in lista:
		resource = getMDBResource (i[0], i[1], endpoint);
	
	print "**************"
	print "* instancia 4*"
	print "**************"
	lista = getLocalLabel("instancia4");
	endpoint = 'http://webenemasuno.linkeddata.es/sparql';
	for i in lista:
		resource = getWebViajeroResource (i[0], i[1], endpoint);
	