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
   

}

class NaveBaliza inherits Nave{
  var color 
  method cambiarColorDeBaliza(nuevoColor){
    color = nuevoColor
  }
  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()  
  } 
}

class NavePasajero inherits Nave{
  const cantPasajeros
  var comida = 0
  var bebida = 0

  method cantBebida() = bebida
  method cantComida() = comida
  method cargarComida(cantidad){
    comida += cantidad
  } 
  method cargarBedida(cantidad){
    bebida += cantidad
  }
  method descargarComida(cantidad){
    comida -= cantidad
  } 
  method descargarBedida(cantidad){
    bebida -= cantidad
  }
  override method prepararViaje(){
    self.cargarComida(4)
    self.cargarBedida(6)
    self.acercarseUnPocoAlSol()
  }
}
class NaveDeCombate inherits Nave{
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
  method esEscueta() = mensajes.all({m => m.length() > 30})
  method emitioMensaje(mensaje) = mensajes.contains(mensaje)
  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitioMensaje("Saliendo en mision")
  } 
}


class NaveHospital inherits NavePasajero{
  var quirofano = false

  method quirofanoPreparado() {
    quirofano = true
  }

  method quirofanoNoPreparado() {
    quirofano = false
    
  }

  method estaPreparado() = quirofano

}

class NaveSigilosa inherits NaveDeCombate{
  override method estaTranquila() =  super() and self.estaVisible() 
}


