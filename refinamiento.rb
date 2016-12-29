require 'geometry'
require_relative './triangulo'

def coordenadas()
  node = []
  File.open('espiral.node','r') do |f| #en espiral.node estan las coordenadas de los puntos
    while linea = f.gets
      node << linea.chop! #chop elimina el ultimo caracter en este caso el salto de linea
    end
  end

  for i in 0..node.length-1
    node[i]= node[i].split(" ")
    for j in 0..node[i].length-1
      if j == 0
        node[i][j]= node[i][j].to_i
      else
        node[i][j]= node[i][j].to_f
      end
    end
  end
  return node
end

def triangulos()
  mesh = []
  File.open('espiral.mesh','r') do |f| # en espiral.mesh estan definidos los triangulos con sus puntos
    while linea = f.gets
      mesh << linea.chop!
    end
  end
  for i in 0..mesh.length-1
    mesh[i]= mesh[i].split(" ")
    for j in 0..mesh[i].length-1
      mesh[i][j]= mesh[i][j].to_i
    end
  end
  return mesh
end
def candidatos()
  candidato =[]
  File.open('candidato.ref', 'r') do |f|
    while linea = f.gets
      candidato << linea.chop!
    end
  end
  for i in 0..candidato.length-1
    candidato[i]= candidato[i].split(" ")
    for j in 0..candidato[i].length-1
      candidato[i][j]= candidato[i][j].to_i
    end
  end
  for i in 0..candidato.length-1
    candidato[i]= candidato[i][1]
  end
  return candidato
end



def cantidadDeTriangulos(mesh)
  largo = mesh[0][0]
  return largo
end

def angulosTriangulos(a,b,c)
  triangulo = Triangulos.new(a,b,c)
  refinar = 0
  if(triangulo.alfa <= 18 || triangulo.beta <= 18 || triangulo.gama <= 18) 
    if (triangulo.alfa > 0 || triangulo.beta > 0 || triangulo.gama > 0 )
      refinar = 1
    end
  end
  return refinar
end

def combinaciones(mesh)
  combinacion = []
  dimension = get_dimension mesh
  if dimension == 1 && mesh.length == 3
    combinacion = mesh.combination(2).to_a
  else
    largo = mesh.length
    if largo > 1
      for i in 0..mesh.length-1
        combinacion << mesh[i].combination(2).to_a
      end
    end
  end
  return combinacion
end


def listaCantidadArefinar()
  mesh = []
  File.open('ref','r') do |f| # en espiral.mesh estan definidos los triangulos con sus puntos
    while linea = f.gets
      mesh << linea.chop!
    end
  end
  for i in 0..mesh.length-1
    mesh[i]= mesh[i].split(" ")
    for j in 0..mesh[i].length-1
      mesh[i][j]= mesh[i][j].to_i
    end
  end
  return mesh
end

def listaCantidadArefinar(mesh,node)
  largo= cantidadDeTriangulos(mesh)
  lista =[]
  for j in 1..largo
    a=0
    b=0
    c=0
    for i in 0..node.length-1
      if mesh[j][0]==node[i][0]
        largo1 =[]
        largo1 << node[i][1]
        largo1 << node[i][2]
      end

      if mesh[j][1]==node[i][0]
        largo2 =[]
        largo2 << node[i][1]
        largo2 << node[i][2]
      end

      if mesh[j][2]==node[i][0]
        largo3 =[]
        largo3 << node[i][1]
        largo3 << node[i][2]
      end
    end
    a= Geometry::Edge.new(largo1,largo2)
    b=Geometry::Edge.new(largo2,largo3)
    c=Geometry::Edge.new(largo1,largo3)
    lista << angulosTriangulos(a.length,b.length,c.length)
  end
  return lista
end

def triangulosArefinar(refinar) #indice del triangulo en el vector
  lista=[]
  for i in 0..refinar.length-1
    if refinar[i]==1
      lista<<i+1
    end
  end
  return lista
end

def toEdge(nodoPrimero,nodoSegundo) # transforma los nodos en objetos edges para poder calcular sus disntancias
  largo1 =[]
  largo2 =[]
  largo1 << nodoPrimero[1] << nodoPrimero[2]
  largo2 << nodoSegundo[1] << nodoSegundo[2]
  geometria = Geometry::Edge.new(largo1,largo2)
  return geometria
end

def puntoMedio(lado,lista) #calcula el punto medio de una distancia
  x = ((lado.first.x + lado.last.x)/2).to_f
  y= ((lado.first.y + lado.last.y)/2).to_f
  auxiliar = 1
  for i in 0..lista.length-1
    if(lista[i][1] ==x && lista[i][2] == y )
      auxiliar = 0
      indice = i
    end
  end
  if auxiliar == 1
    numero  = lista.length+1
    puntoMed = [numero,x,y]
    lista<< puntoMed
  else
    puntoMed = [lista[indice][0],x,y]  
  end
  return puntoMed
end


def calculateTriangle(mesh, node, triangulosArefinar) 
  #refinacion del triangulo y calculo de los triangulos nuevos
  nuevo =[]
  for i in 0..triangulosArefinar.length-1
    nuevo<<mesh[triangulosArefinar[i]]
  end
  return nuevo
end

def verticeMasLargo(a,b,c)
  if a > b && a > c
    lado = 0
  end
  if b >a && b > c
    lado = 1
  end
  if c > a && c > b
    lado = 2
  end
  return lado
end





def buscarNodo(matriz,node)
  uno = matriz[0]
  dos = matriz[1]
  tres = matriz[2]
  for i in 0..node.length-1
    if(uno[0]==node[i][0])
      primerlargo = node[i]
    end
    if(uno[1]==node[i][0])
      segundolargo = node[i]
    end

    if(dos[0]==node[i][0])
      tercerolargo = node[i]
    end
    if(dos[1]==node[i][0])
      cuartolargo = node[i]
    end

    if(tres[0]==node[i][0])
      quintolargo = node[i]
    end
    if(tres[1]==node[i][0])
      sextolargo = node[i]
    end
  end
  a =  toEdge(primerlargo,segundolargo)
  b =  toEdge(tercerolargo,cuartolargo)
  c =  toEdge(quintolargo,sextolargo)
  s = verticeMasLargo(a.length,b.length,c.length)
  return s
end

def buscarPunto(node,arreglo) # busca los nodos 
  nodo = []  
  for i in 0..node.length-1
    for j in 0..arreglo.length-1
      if(arreglo[j] == node[i][0]) # compara el numero del nodo para retornar su nodo completo
        nodo << node[i]
      end
    end
  end
  return nodo
end

def crearTriangulo(mesh,node,listaDeTriangulosArefinar)

  combinacion = combinaciones(listaDeTriangulosArefinar)
  dimension = get_dimension combinacion
  if dimension ==2
    triangulo = combinacion
    lado = buscarNodo(triangulo,node)
    punto = buscarPunto(node,triangulo[lado.to_i])
    edge = toEdge(punto[0],punto[1])
    puntoMedio = puntoMedio(edge,node)
    nuevoTriangulo = []
    for k in 0..triangulo.length-1
      if(k!=lado)
        triangulo[k]<<puntoMedio[0]
        nuevoTriangulo << triangulo[k]
      end
    end
    for j in 0..mesh.length-1
      if(mesh[j]==listaDeTriangulosArefinar)
        mesh[j]= nuevoTriangulo[0]
      end
    end
    mesh<< nuevoTriangulo[1]
    
    igual = iguales(mesh,triangulo,lado)
 
    
    if igual != []
      crearTriangulo(mesh,node,igual)
    end
    mesh[0][0]= mesh.length-1
  end
  if dimension!=2
    for i in 0..combinacion.length-1
      triangulo = combinacion[i]
      lado = buscarNodo(triangulo,node)
      punto = buscarPunto(node,triangulo[lado.to_i])
      edge = toEdge(punto[0],punto[1])
      puntoMedio = puntoMedio(edge,node)
      nuevoTriangulo = []
      for k in 0..triangulo.length-1
        if(k!=lado)
          triangulo[k]<<puntoMedio[0]
          nuevoTriangulo << triangulo[k]
        end
      end
      for j in 0..mesh.length-1
        if(mesh[j]==listaDeTriangulosArefinar[i])
          mesh[j]= nuevoTriangulo[0]
        end
      end
      mesh<< nuevoTriangulo[1]
    
      igual = iguales(mesh,triangulo,lado)
 
      
      if igual != []
        crearTriangulo(mesh,node,igual)
      end
    end
    mesh[0][0]= mesh.length-1
  end
end
  
def iguales(mesh,triangulo,lado)
  combinacion = combinaciones(mesh)
  iguales = []
  for i in 0..combinacion.length-1
    for j in 0..combinacion[i].length-1
      if triangulo[lado] == combinacion[i][j] || triangulo[lado].reverse == combinacion[i][j]
        iguales = mesh[i]
      end 
    end 
  end
  return iguales
end

def get_dimension a  #calcula la dimension del array
  return 0 if a.class != Array
  result = 1
  a.each do |sub_a|
    if sub_a.class == Array
      dim = get_dimension(sub_a)
      result = dim + 1 if dim + 1 > result
    end
  end
  return result
end


def escribirPoly(node,mesh,nombre)
  combinacion = combinaciones(mesh)
  File.open(nombre,'w') do |file|
    file.puts node.length.to_s+" 2 0 0"
    for i in 0..node.length-1
      n = node[i]
      q=' '
      file.puts n[0].to_s+q+n[1].to_s+q+ n[2].to_s
    end
    file.puts (3*(combinacion.length-1)).to_s+" 0"
    aux = 1
    for i in 1..combinacion.length-1
      c = combinacion[i]
      for j in 0..c.length-1
          file.puts aux.to_s+q+c[j][0].to_s+q+c[j][1].to_s+q+c[j][2].to_s  
          aux =aux+1 
      end
    end
    file.puts "0"
  end
end

node = coordenadas()
mesh = triangulos()
escribirPoly(node,mesh,"original.poly")
#candidata = listaCantidadArefinar(mesh,node)
candidata = candidatos()
triangulos = triangulosArefinar(candidata)
vertices = calculateTriangle(mesh,node,triangulos)
inicial = Time.now
crearTriangulo(mesh,node,vertices)
final=Time.now
escribirPoly(node,mesh,"final.poly")
meshoriginal=triangulos()
triangulosGenerados=(meshoriginal[0][0])-(mesh[0][0])
tiempo=final-inicial
puts "tiempo inicial"+inicial.to_s
puts "tiempo final"+final.to_s
puts "tiempo de ejecucion"+tiempo.to_s
puts "numero de triangulos generados"+triangulosGenerados.to_s
