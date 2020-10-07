import objetos.*
import wollok.game.*
import utilities.teclas.*
import mapas.mapa.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado = null
	var property posicionPoder
	var property posicionMartillo
	var property positionInicial
	var ultimaDireccion = "down"
	var puedeConstruir = true
	var movimientosHabilitados = true
	
	const martillo = new Martillo(image = "Objetos/martillo.png", position = self.posicionMartillo())
	
	method iniciar(){
		self.positionInicial()
		self.habilitarConstruccion()
	}
	
	method usarObjeto(){
		if(objetoEncontrado!= null){
		objetoEncontrado.usar(self)
		objetoEncontrado = null
		}
		else {game.say(self,"No tengo ningún objeto")}
	}
	
	method construir(){
		
		if (puedeConstruir) {
			martillo.construir(self)
			puedeConstruir = false
			martillo.desaparecer()
			game.schedule(15000, {self.habilitarConstruccion()})
		}
		else {
			game.say(self,"No puedo construir todavía")
		}
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
		martillo.aparecer()
	}
	
	method nuevaPosicion(direccion){
		if(movimientosHabilitados){
			if (direccion == "up" && position.y()+1 < mapa.bordeSuperior()){
				ultimaDireccion = "up"
				return self.position().up(1)
			}
			if (direccion == "down" && position.y()-1 > mapa.bordeInferior()){
				ultimaDireccion = "down"
				return self.position().down(1)
			}
			if (direccion == "right" && position.x()+1 < mapa.bordeDerecho()){
				ultimaDireccion = "right"
				return self.position().right(1)
			} 
			if (direccion == "left" && position.x()-1 > mapa.bordeIzquierdo()){
				ultimaDireccion = "left"
				return self.position().left(1)
			}
		}
		
		return position

	}
	
	method cambiarImagen(direccion){}
	
	method moverseA(direccion){
		self.cambiarImagen(direccion)
		position = self.nuevaPosicion(direccion)
	}
	
	method quedarseQuieto(milisegundos){
		movimientosHabilitados = false
		game.schedule(milisegundos, {=>movimientosHabilitados = true})
	}
	
	method guardarObjeto(objeto){
		if(objetoEncontrado != null){
			game.removeVisual(objetoEncontrado)
		} 
		objetoEncontrado = objeto.crearReplica(self.posicionPoder())
		game.addVisual(objetoEncontrado)
		objeto.atrapado()
	}
	
	method posicionAModificar(){
		if (ultimaDireccion == "up"){
			return position.up(1)
		} else if (ultimaDireccion == "down"){
			return position.down(1)
		} else if (ultimaDireccion == "right"){
			return position.right(1)
		}
		return position.left(1)
	}

}

object agente inherits Jugador{
	const property contrincante = villano
	const vidas = [vida1, vida2, vida3]
	var property image = "Personajes/agente_adelante.png"
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,5)
	
	override method posicionMartillo() = game.at(0,3)
	
	override method iniciar(){
		super()
		self.mostrarVidas()
	}
	
	method mostrarVidas(){
		vidas.forEach({vida => game.addVisual(vida)})
	}
	
	override method positionInicial(){
		position = game.at(20,6)
	}
	
	method atrapado() {
		self.perderVida()
		villano.atrapar()
	}
	
	method perderVida() {
		const ultimaVida = vidas.last()
		game.removeVisual(ultimaVida)
		vidas.remove(ultimaVida)
		if(vidas.isEmpty()){
			game.say(villano, "Suerte la proxima campeon")
			game.schedule(3000, {game.stop()})
		}
	}	
	
	method recuperarVida(){
		if(vidas.size() == 1){
			vidas.add(vida2)
			game.addVisual(vida2)
		} else if (vidas.size()==2){
			vidas.add(vida3)
			game.addVisual(vida3)
		}
	}	
	
	
// se podria abstraer a la Class Jugador
	override method cambiarImagen(direccion){
		if(direccion == "up"){
			image = "Personajes/agente_back.png"
		} else if (direccion == "right"){
			image = "Personajes/agente_der.png"
		} else if (direccion == "down"){
			image = "Personajes/agente_adelante.png"
		} else if (direccion == "left"){
			image = "Personajes/agente_izq.png"
		}
	}
	
	method teletransportarse(){
		const x = (mapa.bordeIzquierdo()+1).randomUpTo(mapa.bordeDerecho()-1)
		const y = (mapa.bordeInferior()+1).randomUpTo(mapa.bordeSuperior()-1)
		position = game.at (x, y)
	}
}

object villano inherits Jugador{
	const property contrincante = agente
	var property image =  "Personajes/villano_adelante.png"
	
	method esAgente() = false
	
	override method posicionPoder() = game.at(24,5)
	
	override method posicionMartillo() = game.at(24,3)
	
	override method positionInicial(){
		position = game.at(6,7)
	}
	
	method atrapar(){
		self.quedarseQuieto(3000)
		game.say(self, "Una vida menos jajaja")
	}
	
	override method cambiarImagen(direccion){
		if(direccion == "up"){
			image = "Personajes/villano_back.png"
		} else if (direccion == "right"){
			image = "Personajes/villano_back.png"
		} else if (direccion == "down"){
			image = "Personajes/villano_adelante.png"
		} else if (direccion == "left"){
			image = "Personajes/villano_adelante.png"
		}
	}
	
	method ponerPinches(){
		const bomba = new Pinches(image = "Objetos/pinches.png", position = self.posicionAModificar())
		game.addVisual(bomba) 
	}
}

