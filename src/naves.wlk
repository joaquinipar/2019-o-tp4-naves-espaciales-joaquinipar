class Nave {
	
	
	var property velocidad = 0
	
	method superaLimiteVelocidad() { if(velocidad > 300000) velocidad=300000 }
	
	method aumentarVelocidad(aumento) { 
		velocidad = velocidad + aumento
		self.superaLimiteVelocidad()
		
	}
	
	method propulsar() {
		
		self.aumentarVelocidad(20000)
		
	} 
	
	method aceleracionViaje(){
		
		velocidad = 150000
		self.superaLimiteVelocidad()
	}
	
	method prepararseParaViajar(){
		
		self.aumentarVelocidad(15000)
		
	}
	
	method recibirAmenaza(){ }
	
	method encontrarEnemigo(){
		
		self.recibirAmenaza()
		self.propulsar()
		
	}
}

class NaveDeCarga inherits Nave {

	var property carga = 0
	
	

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000
	
	override
	method recibirAmenaza() {
		carga = 0
	}

}

const naveDeCarga = new NaveDeCarga()

class NaveDePasajeros inherits Nave {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma
	
	override
	method recibirAmenaza() {
		alarma = true
	}

}

const naveDePasajeros = new NaveDePasajeros()

class NaveDeCombate inherits Nave {
	
	var property modo = reposo
	const property mensajesEmitidos = []
	

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()
	
	override
	method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
	override
	method prepararseParaViajar(){
		
		self.aumentarVelocidad(15000)
		
		self.aplicar()
	}
	
	
	method aplicar(){
		
		if(modo.tipo() == ataque.tipo() )
			self.emitirMensaje("Volviendo a la base")
		if(modo.tipo() == reposo.tipo())
			self.emitirMensaje("Saliendo en mision")
		
	}
}

class NaveDeCargaRadioactiva inherits NaveDeCarga{
	
	var estaSellado = false
	
	method estaSellado() = estaSellado
	
	override
	method recibirAmenaza() { 
		estaSellado = false
		velocidad = 0
	}
	override 
	method prepararseParaViajar(){
		
		self.aumentarVelocidad(15000)
		
		estaSellado = true
	} 
	
	
}

const NaveDeCargaRadioactiva = new NaveDeCargaRadioactiva()

object reposo {

	var tipo= "reposo"
	
	method tipo() = tipo

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	method mensajeViaje(nave) {
		
		nave.emitirMensaje("Volviendo a la base")
	}

}

object ataque {
	
	var tipo= "ataque" 
	
	method tipo() = tipo
	
	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}

