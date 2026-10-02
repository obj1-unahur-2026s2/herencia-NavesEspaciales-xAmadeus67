class Nave {
  var velocidad = 0
  var direccion = 0 // entre 10 y -10
  var combustible = 0

  method velocidad() = velocidad
  method direccion() = direccion

  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).max(0).min(100000) // revisar
  } 

  method desacelerar(cuanto) {
    velocidad = (velocidad - cuanto).max(0).min(100000) //revisar
  }

  method irHaciaElSol() {
    direccion = 10
  }

  method escaparDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0    
  }

  method acercarseUnPocoAlSol() {
   direccion +=1.min(10).max(-10)
  }

  method alejarseUnPocoDelSol(){
    direccion -=1.min(10).max(-10)
    
  }

  method cargaCombustible(litros) {
    combustible += litros ///
    
  }
  method descargarCombustible(litros) { ///

    combustible -= litros
    
  }

  method prepararViaje()

  method estaTranquila() = combustible >= 4000 and velocidad <= 12000

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar()
  method estaDeRelajo() {
    return self.estaTranquila() 
  }

}

class NaveBaliza inherits Nave {
  var color 
  var cambioElColor = false

  method cambiarColorDeBaliza(nuevoColor){
    color = nuevoColor
    cambioElColor = true
  }
  method cambioElColor() = cambioElColor
  method color() = color

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()  
  } 
  override method estaTranquila() =  super() and self.color() != "rojo"
  override method escapar() { 
    self.irHaciaElSol() 
  } 
  override method avisar() { 
    self.cambiarColorDeBaliza("rojo") 
  }
  override method estaDeRelajo() {
    return super() and self.cambioElColor()
  }

}

class NavePasajero inherits Nave {
  const cantPasajeros
  var comida = 0
  var bebida = 0
  var racionDeComidaServida = 0

  method cantBebida() = bebida
  method cantComida() = comida
  method cargarComida(cantidad){
    comida += cantidad
  } 
  method cargarBebida(cantidad){
    bebida += cantidad
  }
  method descargarComida(cantidad){
    comida -= cantidad
    racionDeComidaServida += cantidad
  } 
  method descargarBebida(cantidad){
    bebida -= cantidad
  }
  method cantDeRacionesDeComidaServidas() {
    return racionDeComidaServida
  }

  override method prepararViaje(){
    self.cargarComida(4)
    self.cargarBebida(6)
    self.acercarseUnPocoAlSol()
  }
  override method escapar() {
    self.acelerar(velocidad*2)
  }
  override method avisar() {
    self.descargarComida(1*cantPasajeros)
    self.descargarBebida(2*cantPasajeros)
  }
  override method estaDeRelajo() {
    return super() and self.cantDeRacionesDeComidaServidas() < 50
  }

}
class NaveDeCombate inherits Nave {
  var visible = true
  var misiles = false
  const mensajes = []

  method ponerseVisible() {
    visible = true
  }  
  method ponerseInvisible() {
    visible = false
  }
  method estaVisible() = visible
  method desplegarMisiles(){
    misiles = true
  }
  method replegarMisiles() {
    misiles = false
  }
  method misilesDesplegados() = misiles 
  method emitirMensaje(mensaje) = mensajes.add(mensaje)
  method mensajesEmitidos() = mensajes
  //method mensajesEmitidos() = mensajes.asList() segunda forma de hacerlo
  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()
  method esEscueta() = !mensajes.all({m => m.length() > 30})
  method emitioMensaje(mensaje) = mensajes.contains(mensaje)

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  } 
  override method estaTranquila() =  super() and !self.misilesDesplegados()
  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }
}


class NaveHospital inherits NavePasajero {
  var quirofano = false

  method quirofanoPreparado() {
    quirofano = true
  }
  method quirofanoNoPreparado() {
    quirofano = false
  }
  method estaPreparado() = quirofano

  override method estaTranquila() =  super() and !self.estaPreparado()
  override method avisar() {
    super()
    self.quirofanoPreparado()
  } //no estoy seguro de en donde hacer el cambio
}

class NaveSigilosa inherits NaveDeCombate {

  override method estaTranquila() =  super() and self.estaVisible() 
  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }

}



