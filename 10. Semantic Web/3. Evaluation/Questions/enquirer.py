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
#
################################



from SPARQLWrapper import SPARQLWrapper, JSON, XML, RDF
import xml.dom.minidom

def getLocalLabel (instancia):
 
 	sparqlSesame = SPARQLWrapper("http://localhost:8080/openrdf-sesame/repositories/SocialNetwork",  returnFormat=JSON)
	queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX sn:  <http://ciff.curso2015/ontologies/owl/socialNetwork#> SELECT ?label WHERE { sn:" + instancia + " rdfs:label ?label }"
	sparqlSesame.setQuery(queryString)
	sparqlSesame.setReturnFormat(JSON)
	query   = sparqlSesame.query()
	results = query.convert()
	for result in results["results"]["bindings"]:
		label = result["label"]["value"]
		lang = result["label"]["xml:lang"]
		print "The label: " + label
		print "The lang: " + lang
	return (label, lang)
		
def getDBpediaResource (label, lang, endpoint):

	sparqlDBPedia = SPARQLWrapper('http://dbpedia.org/sparql')
	if (lang):
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?s WHERE { ?s rdfs:label \"" + label + "\"@" +lang + " . ?s rdf:type foaf:Person} " 
	else:
		queryString = "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX foaf: <http://xmlns.com/foaf/0.1/> SELECT ?s WHERE { ?s rdfs:label \"" + label + "\" . ?s rdf:type foaf:Person } " 
	
	sparqlDBPedia.setQuery(queryString)
	sparqlDBPedia.setReturnFormat(JSON)
	query   = sparqlDBPedia.query()
	results = query.convert()
	for result in results["results"]["bindings"]:
		resource = result["s"]["value"]
		print "The resource: " + resource

if __name__ == '__main__':

	(label, lang) = getLocalLabel("instancia1");
	endpoint = 'http://dbpedia.org/sparql';
	resource = getDBpediaResource (label, lang, endpoint);
	

		