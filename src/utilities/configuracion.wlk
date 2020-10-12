import wollok.game.*
import jugadores.*
import objetos.*
import utilities.teclas.*
import mapas.mapa.*
import villano.*
import agente.*
import paredes.*

object configuracion{
	method iniciar(){
		self.configurarJuego()
		self.agregarPersonajes()
		teclas.configurar()
		self.agregarObjetos()
		self.configurarAcciones()
		mapa.configurarMapa()
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
		agente.iniciar()
		villano.iniciar()
	}
	
	method agregarObjetos(){
		objetoAzul.aparecer()
		objetoVerde.aparecer()
		objetoRojo.aparecer()
		objetoColeccionable1.aparecer()
		objetoColeccionable2.aparecer()
		objetoColeccionable3.aparecer()
		objetoColeccionable4.aparecer()
	}
	
	method configurarAcciones(){
		game.onCollideDo(objetoAzul, {personaje => personaje.guardarObjeto(objetoAzul)})
		game.onCollideDo(objetoRojo, {personaje => personaje.guardarObjeto(objetoRojo)})
		game.onCollideDo(objetoVerde, {personaje => personaje.guardarObjeto(objetoVerde)})
		game.onCollideDo(agente, {objetoEncontrado => objetoEncontrado.interactuar()})
		//game.onCollideDo(Pared, {objeto => objeto.aparecer()})
	}
}
