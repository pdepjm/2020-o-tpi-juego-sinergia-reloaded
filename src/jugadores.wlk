import objetos.*
import habilidades.*
import wollok.game.*
import utilities.teclas.*

class Jugador{
	var property position = game.center()
	var objetoEncontrado
	var property posicionPoder
	var puedeConstruir = true
	const martillo = new Martillo()
	
	method usarObjeto() = objetoEncontrado.usar(self)
	
	method construir(){
		
		if (puedeConstruir) {
			martillo.construir()
			puedeConstruir = false
			martillo.desaparecer()
			//schedule(15000, {self.habilitarConstruccion()})
		}
		else {
			game.say(self,"No puedo construir todavía")
		}
	}
	
	method habilitarConstruccion(){
		puedeConstruir = true
	}
	
	method nuevaPosicion(direccion){
		if (direccion == "up" && position.y()+1 < 14){
			return self.position().up(1)
		}
		if (direccion == "down" && position.y()-1 > 0){
			return self.position().down(1)
		}
		if (direccion == "right" && position.x()+1 < 27){
			return self.position().right(1)
		} 
		if (direccion == "left" && position.x()-1 > 1){
			return self.position().left(1)
		}
		return position

	}
	
	method moverseA(direccion){
		position = self.nuevaPosicion(direccion)
	}
	
	method quedarseQuieto(milisegundos){
		teclas.desconfigurar(self)
		//schedule(milisegundo, {=>teclas.configurar()})
	}
	
	method guardarObjeto(objeto){
		objetoEncontrado = objeto
		objeto.atrapado(self.posicionPoder())
		objeto.aparecer()
	}
	
// sería igual que construir pero con otro metodo para el martillo asi que hay que abstraer la logica
//	method destruir() = 


}

object agente inherits Jugador{
	const property contrincante = villano
	var vidas = 3
	method image() = "jugador.png"
	
	method esAgente() = true
	
	override method posicionPoder() = game.at(0,5)
	
	method positionInicial(){
		position = game.at(20,6)
	}
	
	method atrapado() {
		self.perderVida()
		villano.atrapar()
	}
	
	method perderVida() {
		vidas -= 1
		if(vidas == 0){
			game.say(villano, "Suerte la proxima campeon")
			game.schedule(5000, {game.stop()})
		}
	}	
	
	method recuperarVida(){
		if(vidas < 3){
			vidas += 1
		}
	}	
	
	override method habilitarConstruccion(){
		super()
		game.addVisualIn(martillo, game.at(0,1))
	}
}

object villano inherits Jugador{
	const property contrincante = agente
	method image() = "villano.png"
	
	method esAgente() = false
	
	override method posicionPoder() = game.at(25,5)
	
	override method habilitarConstruccion(){
		super()
		game.addVisualIn(martillo, game.at(25,1))
	}
	
	method positionInicial(){
		position = game.at(6,7)
	}
	
	method atrapar(){
		self.quedarseQuieto(3000)
		game.say(self, "Una vida menos jajaja")
	}
}

