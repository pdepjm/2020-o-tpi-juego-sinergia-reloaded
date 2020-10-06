import wollok.game.*
import jugadores.*
import objetos.*
import utilities.teclas.*
import mapas.mapa.*

object buscandoLosArchivos {
	method iniciar(){
		self.configurarJuego()
		self.agregarPersonajes()
		teclas.configurar()
		self.agregarObjetos()
		self.configurarAcciones()
		game.start()
	}
	
	method configurarJuego(){
		game.width(25)
		game.height(14)
		game.title("Juego Base")
		game.boardGround("piso.png")
		//mapa.configurarMapa()
	}
	
	method agregarPersonajes(){
		game.addVisual(villano)
		game.addVisual(agente)
		agente.iniciar()
		villano.iniciar()
	}
	
	method agregarObjetos(){
		objetoAzul.aparecer()
		objetoVerde.aparecer()
		objetoRojo.aparecer()
	}
	
	method configurarAcciones(){
		game.onCollideDo(objetoAzul, {personaje => personaje.guardarObjeto(objetoAzul)})
		game.onCollideDo(objetoRojo, {personaje => personaje.guardarObjeto(objetoRojo)})
		game.onCollideDo(objetoVerde, {personaje => personaje.guardarObjeto(objetoVerde)})
		game.onCollideDo(villano, {personaje => personaje.atrapado()})
		game.onCollideDo(agente, {pinches=>pinches.pinchar()})
	}
}
