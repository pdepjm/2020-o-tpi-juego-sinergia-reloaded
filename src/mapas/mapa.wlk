import wollok.game.*

class LimiteDelMapa{
	var property image = "Objetos/pared1.png"
}

object mapa {
	const property bordeSuperior = 14
	const property bordeInferior = 0
	const property bordeDerecho = 24
	const property bordeIzquierdo = 0	
	
	method configurarMapa(){
		self.configurarLimites()
		
	}
	
	method configurarLimites(){
		
		(bordeInferior..bordeSuperior).forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,numero))}
		(bordeInferior..bordeSuperior).forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,numero))}
		(bordeIzquierdo..bordeDerecho).forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeInferior))}
		(bordeIzquierdo..bordeDerecho).forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeSuperior))}

	}
	
}

