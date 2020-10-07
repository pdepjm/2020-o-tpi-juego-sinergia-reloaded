import wollok.game.*
import objetos.*

class LimiteDelMapa{
	var property image = "muro.png"
}

object mapa {
	const property bordeSuperior = 13
	const property bordeInferior = 0
	const property bordeDerecho = 23
	const property bordeIzquierdo = 1	
	
	method configurarMapa(){
		self.configurarLimites()
		
	}
	
	method configurarLimites(){
		
		// [bordeInferior..bordeSuperior].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,numero))}
		// [bordeInferior..bordeSuperior].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,numero))}
		// [bordeIzquierdo..bordeDerecho].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeInferior))}
		// [bordeIzquierdo..bordeDerecho].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeSuperior))}
		
		// Yo no queria matar a esos gatitos, ELLOS ME OBLIGARON :( T.t
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,0))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,1))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,2))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,3))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,4))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,5))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,6))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,7))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,8))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,9))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,10))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,11))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,12))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,13))
		
		// muchos gatitos....
		
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,0))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,1))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,2))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,3))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,4))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,5))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,6))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,7))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,8))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,9))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,10))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,11))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,12))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,13))
		game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,14))
		
		// definitivamente voy a tener un trauma de grande
		
		
		
	}
	
	
}

