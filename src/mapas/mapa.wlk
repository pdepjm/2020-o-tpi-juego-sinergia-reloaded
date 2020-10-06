import wollok.game.*

class LimiteDelMapa{
	method imagen()= "muroInamobible.png"
}

object mapa {
	method configurarMapa(){
		self.configurarLimites()
	}
	
	method configurarLimites(){
		game.addVisualIn(new LimiteDelMapa(), game.at(1,0))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,1))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,2))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,3))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,4))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,5))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,6))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,7))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,8))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,9))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,10))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,11))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,12))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,13))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,14))
		game.addVisualIn(new LimiteDelMapa(), game.at(1,15))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,0))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,1))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,2))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,3))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,4))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,5))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,6))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,7))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,8))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,9))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,10))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,11))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,12))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,13))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,14))
		game.addVisualIn(new LimiteDelMapa(), game.at(24,15))
	}
}
