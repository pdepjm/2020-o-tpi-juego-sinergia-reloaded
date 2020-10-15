import objetos.*
import wollok.game.*

/*object paredes{
	const posicionesOcupadas = new Set()
	
	method agregarPared(posicion){
		posicionesOcupadas.add(posicion)
		const pared = new Pared(image = "muro.png", position = posicion)
		pared.aparecer()
	}
	
	method posicionDisponible(posicion) = !posicionesOcupadas.contains(posicion)
	
	method sacarPared(posicion){
		
		posicionesOcupadas.remove(posicion)
		posicion.clear()
	
	}
}*/


object paredes{
	const posicionesOcupadas = new Set()
	
	method agregarPared(posicion){
		posicionesOcupadas.add(posicion)
		const pared = new Objeto(image = "Objetos/pared2.png", position = posicion)
		pared.aparecer()
	}
	
	method posicionDisponible(posicion) = !posicionesOcupadas.contains(posicion) && laberinto.celda_disponible(posicion)
	
	method sacarPared(posicion){
		if(posicionesOcupadas.contains(posicion)){
			posicionesOcupadas.remove(posicion)
			posicion.clear()
		}
	}
}

object laberinto{
	const position_laberinto = new Set()
	const esquema_laberinto = new Set()
	
	method boceto(){
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(2,12)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(2,6)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(3,12)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(3,11)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(3,10)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(3,2)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(4,10)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(4,4)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(4,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(4,2)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(5,10)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(6,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(7,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(7,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(7,8)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(8,8)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(8,7)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(8,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(9,6)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(10,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(10,12)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(10,1)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(11,5)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(11,1)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(12,4)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(13,9)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(14,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(14,9)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(14,8)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(14,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(15,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(17,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(17,9)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(17,8)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(17,7)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(18,13)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(18,12)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(18,4)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(18,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(19,12)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(19,5)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(20,5)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(20,1)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(21,10)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(21,11)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(21,3)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(22,11)))
		esquema_laberinto.add(new Objeto(image = "Objetos/pared1.png", position = game.at(22,3)))



		esquema_laberinto.forEach({objeto => position_laberinto.add(objeto.position())})
	}		
	
	method mostrar() = esquema_laberinto.forEach({objeto => objeto.aparecer()})
	
	method bloqueado(position) = position_laberinto.contains(position)
	
	method celda_disponible(posicion) = !self.bloqueado(posicion)
}
