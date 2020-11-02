#Informe de Aplicaci�n de los Conceptos de PdeP

##Polimorfismo

Mensaje polim�rfico: usar(jugador)

Objetos que lo implementan	Objeto que lo aprovecha	Ventaja
objetoAzul
objetoRojo
objetoVerde	agente y villano: en el metodo usarObjeto(), independientemente de que jugador sea (es un metodo heredado de la clase Jugador), este hace objetoEncontrado.usar(self) y no le importa lo hace cada objeto de poder encontrado, s�lo los trata polim�rficamente. ver grafico	Se pueden agregar Objetos de poder al tablero para que sean colisionados con los jugadores sin modificar absolutamente nada del c�digo, s�lo basta con agregar el objeto o clase que implemente el m�todo usar(personaje)
		
<img src="scr/Objetos/polimorfismo1.png">

##Colecciones

###�Qu� operaciones de colecciones se utilizan? �Usaron mensajes con y sin efecto? �Para qu�?
operaci�n de Colecci�n	con efecto	sin efecto	�Para qu�?
isEmpty()		x	Es usada para consultar si una posici�n en el tablero esta disponible, para esto hacemos una lista de todos los objetos que se encuentran en la posici�n y despu�s validamos si esta vac�a
game.getObjectsIn(position).isEmpty()

last()		x	Es usada para obtener el �ltimo objeto coleccionable obtenido por el agente
objetosColeccionados.last()

remove(objetoPerdido)	x		Es usada para eliminar el objeto coleccionable pasado por parametro de la lista del agente, cuando es atacado por un poder del villano
objetosColeccionados.remove(objetoPerdido)

add(coleccionable)	x		Es usada para agregar a la lista de objetos coleccionbles del agente un nuevo art�culo
objetosColeccionados.add(coleccionable)

size()		x	Es usada para objetener la cantidad de objetos recolectados por el agente
objetosColeccionados.size()

forEach()	x		es usado para mostrar cada uno de los elementos de la lista de vidas
lista.forEach({vida => game.addVisual(vida)})

tambien se aplico para que aparecieran los muros del laberinto, entre otros elementos de dise�o de la pantalla
elementos.forEach({objeto => objeto.aparecer()})

y por ejemplo, para accionar cada posicion del reloj para actualizar la imagen a mostrar de acuerdo a los segundos de my_clock
init_clock.forEach({objeto => objeto.accionar()})

get(indice)		x	es usado para obtener un string de la lista de clock de acuerdo a la posicion pasada por parametro, para posteriomente actualizar el path de la imagen de una posicion del reloj
clock.get(indice)

contains		x	es usado para consultar si la posicion pasado por parametro no pertenece a la coleccion de posiciones ocupadas del objeto paredes y asi validar si es una celda disponible del tablero
!posicionesOcupadas.contains(posicion)

Tambi�n es usada con el mismo pr�posito con el objeto laberinto
not position_laberinto.contains(position)
			

##Clases 

###�Usan clases? �Por qu�?
hicimos el uso de clases, porque se not� un comportamiento entre distinto objetos que era similar, por lo que se busc� abstraer lo mejor posible este comportamiento compartido y crear un "molde", para evitar la repetici�n de c�digo. Tambi�n nos percatamos de que queriamos agregar funcionalidades como los "pinches" o "crear paredes", que consist�a solo en replicar muchos objetos con el mismo comportamiento y la misma estructura resultando conveniente el uso de las clases.  Finalmente result� en las sgtes clases:

objeto: es la clase m�s general que ejecuta que un objeto aparezca y desaparezca del tablero 
ObjetoAleatorio: redefine el metodo de aparecer de la clase Objeto
ObjetoColeccionable: desarrolla los mensajes que debe entender un objeto coleccionable para que ejecute un comportamiento espec�fico
Poder: esta clase se enfoca a los mensajes que debe entender un objeto de poder 
LiquidoAzul: describe el comportamiento que debe ejecutar el poder azul independientemente del juegador que lo acceda
LiquidoVerde: describe el comportamiento que debe ejecutar el poder verde independientemente del juegador que lo acceda
LiquidoRojo: describe el comportamiento que debe ejecutar el poder rojo independientemente del juegador que lo acceda
Pinches: define el comportamiento de las trampas colocadas por el villano.
Reloj: define el comportamiento de una de las posiciones del reloj

###�D�nde o cu�ndo se instancian los objetos?
objeto: es instanciada, por ejemplo, en pantalla.wlk, donde se tiene las referencias icono_agente e icono_villano que apunta a objetos que son instancias de esta clase. De igual forma, se encuentran otros objetos de dise�o de la pantalla.
const icono_agente = new Objeto(image = "Objetos/icono_agente.png", position = game.at(11,15))

ObjetoAleatorio: no se instancia est� clase, ya que es una clase abstracta, que s�lo existe para poder compartir c�digo entre sus subclases, no para crear objetos a partir de ella.

ObjetoColeccionable: es instanciada, por ejemplo, en objetos.wlk, para cada uno de objetos que el agenete debe recoger (4 en total)
const objetoColeccionable1 = new ObjetoColeccionable(image="Objetos/potion.png", position= game.at(10,8), posicionDestino= game.at(17,15))

Poder: no se instancia est� clase, ya que es una clase abstracta, que s�lo existe para poder compartir c�digo entre sus subclases, no para crear objetos a partir de ella.

LiquidoAzul: es instanciada, por ejemplo, en objetos.wlk
const objetoAzul = new LiquidoAzul(image="Objetos/objeto_azul.png", position = game.at(16,5))	

LiquidoVerde: es instanciada, por ejemplo, en objetos.wlk
const objetoVerde = new LiquidoVerde(image="Objetos/objeto_verde.png", position = game.at(4,10))

LiquidoRojo: es instanciada, por ejemplo, en objetos.wlk
const objetoRojo = new LiquidoRojo(image="Objetos/objeto_rojo.png", position = game.at(10,9))

Pinches: es instanciada, por ejemplo, en villano.wlk, para referencia una "bomba" y poderla mostrar en pantala 
const bomba = new Pinches(image = "Objetos/pinches.png", position = direccion)

Reloj: es instanciada, por ejemplo, en pantalla.wlk, para referenciar los sgundos del tiempo de la partida, por lo que hay una posicion 1 representa las centenas de los segundos, la posicion las decenas y la posicion 3 las unidades
const posc1 = new Reloj( indice = seg.div(100), clock_posc = new Objeto(image = "Objetos/cero.png", position = game.at(6,15)))

##Herencia
###�Entre qui�nes y por qu�? 
Padre	Hijos	�por qu�? 
Objeto	ObjetoAleatorio	

�Qu� comportamiento es com�n y cu�l distinto?

en ObjetoAleatorio se redefinio el metodo 

<img src="scr/Objetos/herencia.png">


##Composici�n
###�Qu� objetos interact�an? �D�nde se delega? �Por qu� no herencia?



notas
revisar el foreach: no estoy segura si afirmar que causa efecto
revisar la clase poder: no encontre ninguna instancia en el TP, asum� que era una clase abastracta
polimorfismo: no recuerdo donde m�s se hace polimorfismo
herencia: me falt� terminar esta parte