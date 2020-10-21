import objetos.*
import wollok.game.*

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
	const position_laberinto = #{
		game.at(2,12),
		game.at(2,6),
		game.at(3,12),
		game.at(3,11),
		game.at(3,10),
		game.at(3,2),
		game.at(4,10),
		game.at(4,4),
		game.at(4,3),
		game.at(4,2),
		game.at(5,10),
		game.at(6,13),
		game.at(7,13),
		game.at(7,3),
		game.at(7,8),
		game.at(8,8),
		game.at(8,7),
		game.at(8,3),
		game.at(9,6),
		game.at(10,13),
		game.at(10,12),
		game.at(10,1),
		game.at(11,5),
		game.at(11,1),
		game.at(12,4),
		game.at(13,9),
		game.at(14,13),
		game.at(14,9),
		game.at(14,8),
		game.at(14,3),
		game.at(15,3),
		game.at(17,13),
		game.at(17,9),
		game.at(17,8),
		game.at(17,7),
		game.at(18,13),
		game.at(18,12),
		game.at(18,4),
		game.at(18,3),
		game.at(19,12),
		game.at(19,5),
		game.at(20,5),
		game.at(20,1),
		game.at(21,10),
		game.at(21,11),
		game.at(21,3),
		game.at(22,11),
		game.at(22,3)
	}
	
	method mostrar() = position_laberinto.forEach({posicion => new Objeto(image = "Objetos/pared1.png", position = posicion).aparecer()})
	
	method celda_disponible(position) = not position_laberinto.contains(position)
}
