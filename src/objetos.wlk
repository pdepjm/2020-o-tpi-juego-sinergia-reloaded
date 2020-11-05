import wollok.game.*
import jugadores.*
import mapas.mapa.*
import villano.*
import agente.*
import paredes.*
import utilities.aleatorio.*
import utilities.direcciones.*
import utilities.pantalla.*


class Objeto {
	var property image = "Objetos/objeto_azul.png"
	var property position = up
	
	method sonido(){
		game.sound("Musica/encontrar_objeto.mp3").play()
	}
	
	method aparecer(){
		game.addVisual(self)
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
}

class ObjetoAleatorio inherits Objeto{
	override method aparecer() {
		position = aleatorio.nuevaPosicion()
		super()
	}
}

class ObjetoColeccionable inherits ObjetoAleatorio{
	var property posicionDestino

    method atrapado(){
		self.desaparecer()
		position = posicionDestino
		game.addVisual(self)
	}
	
	method interactuar(){ 
		self.sonido()
		self.atrapado()
		agente.guardarColeccionable(self)
	}
	
	method reaparecer() {
		self.desaparecer()
		self.aparecer()
	}
	
	method guardarObjeto(objeto){
		objeto.aparecer()
	}
}

class Poder inherits ObjetoAleatorio{
	method crearReplica(direccion){return new Objeto()}
	
	method atrapado(){
		self.sonido()
		self.desaparecer()
		self.aparecer()
	}
	
	method usar(jugador) {
		self.desaparecer()
	}	
}

class LiquidoAzul inherits Poder{
	override method crearReplica(direccion){
		return new LiquidoAzul(image="Objetos/objeto_azul.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.contrincante().quedarseQuieto(3000)
		super(jugador)
	}
}

class LiquidoVerde inherits Poder {
	override method crearReplica(direccion){
		return new LiquidoVerde(image="Objetos/objeto_verde.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.usarObjetoVerde()
		super(jugador)
	}
}

class LiquidoRojo inherits Poder {
	override method crearReplica(direccion){
		return new LiquidoRojo(image="Objetos/objeto_rojo.png", position = direccion)
	}
	
	override method usar(jugador){
		jugador.usarObjetoRojo()
		super(jugador)
	}
}

class Pinches inherits Objeto {
	method interactuar(){
		agente.perderVida()
		self.desaparecer()
	}
}

class Martillo inherits Objeto {
	method modificarMapa(persona){
		const direccion = persona.ultimaDireccion().proximo(persona)
		if(paredes.posicionDisponible(direccion))
			paredes.agregarPared(direccion)
		else 
			paredes.sacarPared(direccion)
	}
}

class Reloj inherits Objeto {
	var property indice
	var property clock_posc
	const clock = ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"]
	
	override method aparecer(){ clock_posc.aparecer()}
	
	method accionar(){
		clock_posc.desaparecer()
		self.actualizarImagen()
		clock_posc.aparecer()
	}
	
	method actualizarImagen(){
		const new_image = "Objetos/" + clock.get(indice) + ".png"
		clock_posc.image(new_image)
	}
}


/////////////////////////////
//--------- VIDAS ---------//
/////////////////////////////
object vidas {
	const lista = [	new Objeto(image = "Objetos/vida.png", position = game.at(13,15)),
					new Objeto(image = "Objetos/vida.png", position = game.at(14,15)),
					new Objeto(image = "Objetos/vida.png", position = game.at(15,15))
				  ] 
	const ultimaVidaSacada = []
	
	method sacar(){
		const ultimaVida = lista.last()
		game.removeVisual(ultimaVida)
		ultimaVidaSacada.add(ultimaVida)
		lista.remove(ultimaVida)
		game.say(villano, "jaja, Perdiste una vida")
	}
	
	method agregar(){
		if(!ultimaVidaSacada.isEmpty()){
			const agregar = ultimaVidaSacada.last()
			game.addVisual(agregar)
			ultimaVidaSacada.remove(agregar)
		}
	}
	
	method mostrar(){
		lista.forEach({vida => game.addVisual(vida)})
	}
}


/////////////////////////////
//---- OBJETOS DE PODER ---//
/////////////////////////////
const objetoAzul = new LiquidoAzul(image="Objetos/objeto_azul.png", position = game.at(16,5))
const objetoVerde = new LiquidoVerde(image="Objetos/objeto_verde.png", position = game.at(4,10))
const objetoRojo = new LiquidoRojo(image="Objetos/objeto_rojo.png", position = game.at(10,9))


/////////////////////////////
//- OBJETOS COLECCIONABLES-//
/////////////////////////////
const objetoColeccionable1 = new ObjetoColeccionable(image="Objetos/potion.png", position= game.at(10,8), posicionDestino= game.at(17,15))
const objetoColeccionable2 = new ObjetoColeccionable(image="Objetos/dragon.png", position= game.at(10,8), posicionDestino= game.at(18,15))
const objetoColeccionable3 = new ObjetoColeccionable(image="Objetos/papiro.png", position= game.at(10,8), posicionDestino= game.at(19,15))
const objetoColeccionable4 = new ObjetoColeccionable(image="Objetos/skull.png", position= game.at(10,8), posicionDestino= game.at(20,15))




