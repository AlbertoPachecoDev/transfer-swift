/*:
 # Caso de Estudio (Swift)
 
 Transferencia y consolidación de competencias de __Pensamiento Computacional__ usando el lenguaje de programación Swift por niveles (básico, intermedio y avanzado).
 
 Elaborados por Alberto Pacheco (alberto@acm.org)
 
 Swift 5, ver 2.0, CC-BY-NC 2021
 
 ---
 
 ### Caso de Estudio
 
 __Abordaje siguiendo los componentes básicos del Pensamiento Computacional:__
 
 1. Planteamiento del Problema.
 2. Descomposición.
 3. Abstracción.
 4. Patrones de Diseño.
 
 
 __1. Planteamiento del Problema__: Dado un conjunto de cantidades expresadas en pulgadas, obtener las tres cantidades mas altas ordenadas de mayor a menor, dichas cantidades deben estar expresadas en centímetros y ser inferiores a una límite específico (i.e., 40.0cm).
 
 >__Transferencia:__ Implementar por etapas (_transferencia progresiva/evolutiva_) primero la solución en Swift y posteriormente en Python (_transferencia notacional y algorítmica_) aplicando en lo posible los mismos conceptos básicos y principios.
 
 __2. Descomposición:__ Abordaje didáctico y estrategia para resolver el problema:
 
 - _Nivel Básico: Metáfora de la "Calculadora"._ Realizar la conversion, transformación de formato de las cantidades a considerar.
 
 - _Nivel Intermedio: Metáfora de la "tubería y el flujo de datos"_. Aplicar el procesamiento de datos del nivel anterior a un conjunto de datos.
 
 - _Nivel Avanzado: Modelado basado en Cálculo Lambda y Procesamiento basado en Tuberías (Pipes)_. Realizar en cascada las transformaciones requeridas de tal forma que pueda generalizarse y sea posible <u>transferir</u> más fácilmente la solución para problemas similares (otro tipo de conversiones, filtros, formatos y transformaciones), incluso a otro lenguaje de programación.

 ---
 
## Nivel 1: Metáfora _"Computación como Calculadora"_

 __Planteamiento del Sub-problema:__ Realizar la conversión de una cantidad expresada en pulgadas a centímetros.
 
 >Entrada: Cantidad numérica para pulgadas\
 Salida: Cantidad numérica para centímetros\
 Proceso: Expresión aritmética para conversión de pulgadas a centímetros (fórmula)
 
 ### Básico: etapa-1
 
 Expresión simple: operadores, variables y constantes con un tipo de dato.
 */

let pulg = 5.2
let cm = pulg * 2.54
print("Nivel 1, etapa 1")
print("\t\(pulg) in = \(cm) cm")

/*:
 ### Básico: etapa-2
 Funciones como mecanismo de descomposición y *abstracción simbólica*
*/

// Tipo de Dato Abstracto para Distancias
typealias Dist = Double

// Conversión: Pulgadas a centímetros
func in2cm(_ pulg: Dist) -> Dist {
    return pulg * 2.54
}

// Formato: Cantidad con dos decimales
func dec2(_ num: Dist) -> Dist {
    return (num * 100.0).rounded() / 100.0
}

// Reporte del resultado
print("Nivel 1, etapa 2")
func p(_ x: Dist, _ y: Dist) {
    print("\t\(x) in = \(y) cm")
}

// Solución simbólica
p( pulg, dec2(in2cm(pulg)) )

/*:
 ## Nivel 2: Metáfora _"Tuberías"_
 
 [Functional Programming in Swift](https://www.vadimbulavin.com/pure-functions-higher-order-functions-and-first-class-functions-in-swift/)
 
 [An Introduction to Functional Programming in Swift](https://www.raywenderlich.com/9222-an-introduction-to-functional-programming-in-swift)
 
 Using [Closures](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)
 
 ### Intermedio: etapa-3
 */

let datos = [5.2, 19.6, 3.7, 12.1, 16.5, 9.2]
print("Nivel 2, etapa 3")
for x in datos {
    p(x, dec2(in2cm(x)))
}

/*:
 ### Intermedio: etapa-4
 Extensión de tipos de datos y propiedades calculadas
 */

extension Dist {
    
    var dec2 : Dist {
        return (self * 100.0).rounded() / 100.0
    }
    
    var in2cm : Dist {
        return self * 2.54
    }
    
    func pad(_ len: Int) -> String {
        assert(len > 0, "Error: length <= 0") // error handling
        let s = String(self)
        let tam = s.count
        assert(len >= tam, "Error: length < tam") // error handling
        return String(repeating:" ", count: len - tam) + s
    }
}

func r(_ x: Dist, _ y: Dist) {
    print("\t\(x.dec2.pad(6)) in = \(y.dec2.pad(6)) cm")
}

print("Nivel 2, etapa 4")
print("Sin formato:")
for x in datos {
    p(x, x.in2cm)
}
print("Con formato:")
for x in datos {
    r(x, x.in2cm)
}

/*:
 ## Nivel 3:  Metáfora _"Tuberías"_
 
 __Programación Funcional__: Modelo basado en Funciones Lambda
 
 ### Avanzado: etapa-5
 
 Ver. 1: Usando ciclos y funciones:
 */

let conv = { (x: Dist) -> String in "\(x.pad(6)) pulg  -> \(x.in2cm.dec2.pad(6)) cm" }
print("Nivel 3, etapa 5 (imperativa, ver. 1)")
for x in datos.map(conv) {
    print(x)
}

/*:
 ### Avanzado: etapa-5
 
 Ver 2: Usando cerraduras (closures) y algoritmos

 */
print("Nivel 3, etapa 5 (funcional, ver. 2)")
let r = datos
    .map    { $0.in2cm }
    .filter { (10...40).contains($0) }
    .sorted ( by: > )
    .prefix ( upTo: 3 )
    .map    { $0.dec2 }
print("\tTOP 3 =", r)


/*:
 ### Avanzado: etapa-6
 
 Ver 3: Definiendo función top3()
 */

func top3(_ d: [Double]) -> [Double] {
    return Array(d.map { $0.in2cm }.filter { (10...40).contains($0) }.sorted(by: >).map { $0.dec2 }.prefix(upTo: 3))
}
print("Nivel 3, etapa 6 (ver. 3)")
print("\tTOP 3:")
for x in top3(datos) {
    print("\t\t", x, "cm")
}

/*:
 Ver 4: Definiendo cerradura top_3
 */

let top_3 = { (d: [Dist]) -> [Dist] in Array(d.map { $0.in2cm }.filter { (10...40).contains($0) }.sorted(by: >).map { $0.dec2 }.prefix(upTo: 3))}
print("Nivel 3, etapa 6 (ver. 4)")
print("\tTOP 3:")
for x in top_3(datos) {
    print("\t\t", x, "cm")
}


/*:
 Ver 5: Generalizando con cerradura top_n
 */

func top_n(_ d: [Dist], mn: Dist, mx: Dist, n: Int) -> [Dist] {
    assert((1...d.count).contains(n), "Error: invalid parameter n")
    return Array(d.map { $0.in2cm }.filter { (mn...mx).contains($0) }.sorted(by: >).map { $0.dec2 }.prefix(upTo: n))
}
print("Nivel 3, etapa 6 (ver. 5)")
for x in top_n(datos, mn: 10, mx: 40, n:3) {
    print("\t\t", x, "cm")
}

/*:
 ### Solución Final
 */

typealias ListDist  = [Dist]

typealias RangoDist = (min: Dist, max: Dist)

extension ListDist
{
    var in_2_cm: ListDist {
        return self.map { $0.in2cm }
    }
    func en_rango(_ r: RangoDist) -> ListDist {
        let (mn, mx) = r
        return self.filter { (mn...mx).contains($0) }
    }
    var ord_may: ListDist {
        return self.sorted().reversed()
    }
    var decim_2: ListDist {
        return self.map { $0.dec2 }
    }
    func top_n(_ n: Int) -> ListDist {
        return Array(self.prefix(upTo: n))
    }
}

func top(lista: ListDist, rango: RangoDist, tamaño n: Int) -> ListDist {
    assert((1...lista.count).contains(n), "Error: invalid parameter n")
    return lista
        .in_2_cm
        .en_rango(rango)
        .ord_may
        .top_n(n)
        .decim_2
}

extension Dist {
    var cm2in: Dist {
        return self / 2.54
    }
}

let top3 = top(lista:datos, rango:(min:10, max:40), tamaño:3)
print("Nivel 3, etapa 6 (ver. final)")
for cm in top3  {
    r(cm.cm2in.dec2, cm)
}

/*:
 ### Extra: ¿Es posible generalizar para cualquier tipo de conversión?
 */

typealias ConvOp = (Dist) -> Dist

extension ListDist {
    func convertir(_ op: ConvOp) -> ListDist {
        return self.map { op($0) }
    }
}

func conv_top_n(lista: ListDist, rango: RangoDist, tamaño n: Int, op: ConvOp) -> ListDist {
    return lista
        .convertir(op)
        .en_rango(rango)
        .ord_may
        .top_n(n)
        .convertir(dec2)
}

let a_pulg: ConvOp = {x in return x / 2.54}

let t3 = conv_top_n(lista:datos, rango:(min:10, max:40), tamaño:3, op: in2cm)
let to_in = top3.convertir(a_pulg)
print("Nivel 3, etapa 7 (operadores genéricos)")
for (i,cm) in t3.enumerated() {
    r(to_in[i], cm)
}
