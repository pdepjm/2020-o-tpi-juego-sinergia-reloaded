import wollok.game.*

class LimiteDelMapa{
	method imagen()= "muro.png"
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
		[bordeInferior..bordeSuperior].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeIzquierdo,numero))}
		[bordeInferior..bordeSuperior].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(bordeDerecho,numero))}
		[bordeIzquierdo..bordeDerecho].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeInferior))}
		[bordeIzquierdo..bordeDerecho].forEach{numero => game.addVisualIn(new LimiteDelMapa(), game.at(numero,bordeSuperior))}
	}
}
