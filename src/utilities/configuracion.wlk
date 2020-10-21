import wollok.game.*
import objetos.*
import jugadores.*
import villano.*
import agente.*
import mapas.mapa.*
import paredes.*
import utilities.teclas.*
import utilities.pantalla.*
import utilities.aleatorio.*

object configuracion{
	method iniciar(){
		self.configurarJuego()
		teclas.configurar()
		self.agregarObjetos()
		self.agregarPersonajes()
		self.configurarAcciones()
		mapa.configurarMapa()
		game.start()
		
	}
	
	method configurarJuego(){
		game.width(25)
		game.height(17)
		game.title("Juego Base")
		game.boardGround("Objetos/piso.png")
		mapa.configurarMapa()
	}
	
	method agregarPersonajes(){
		agente.iniciar()
		villano.iniciar()
	}
	
	method agregarObjetos(){
		laberinto.mostrar()
		objetoAzul.aparecer()
		objetoVerde.aparecer()
		objetoRojo.aparecer()
		objetoColeccionable1.aparecer()
		objetoColeccionable2.aparecer()
		objetoColeccionable3.aparecer()
		objetoColeccionable4.aparecer()
		pantalla.aparecer()
		icono_agente.aparecer()
		icono_villano.aparecer()		
	}
	
	method configurarAcciones(){
		
		game.onCollideDo(objetoAzul, {personaje => personaje.guardarObjeto(objetoAzul)})
		game.onCollideDo(objetoRojo, {personaje => personaje.guardarObjeto(objetoRojo)})
		game.onCollideDo(objetoVerde, {personaje => personaje.guardarObjeto(objetoVerde)})
		game.onCollideDo(agente, {objetoEncontrado => objetoEncontrado.interactuar()})
		my_clock.iniciar()
		villano.tiempo_partida()
	}
}
