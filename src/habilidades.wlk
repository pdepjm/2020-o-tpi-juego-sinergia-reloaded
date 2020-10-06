import wollok.game.*
import jugadores.*

class Martillo {
	method image() = "Objetos/martillo.png"
	
	method construir(){
		
	}
	
	method aparecer(x, y){
		game.addVisualIn(self, game.at(x,y))
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
}
