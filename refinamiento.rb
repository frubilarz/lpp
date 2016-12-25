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
      node[i][j]= node[i][j].to_f
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


def cantidadDeTriangulos(mesh)
  largo = mesh[0][0]
  return largo
end

def angulosTriangulos(a,b,c)
  triangulo = Triangulos.new(a,b,c)
  refinar = 0
  if(triangulo.alfa < 18 || triangulo.beta < 18 || triangulo.gama < 18)
    refinar =1
  end
  return refinar
end

def combinaciones(mesh)
  largo = mesh.length
  combinacion = []
  if largo ==1
    combinacion << mesh.combination(2).to_a
  end
  if largo > 1
    for i in 1..mesh.length-1
      combinacion << mesh[i].combination(2).to_a
    end
  end
  return combinacion
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

def puntoMedio(lado,lista,mesh) #calcula el punto medio de una distancia
  x = (lado.first.x + a.first.x)/2
  y= (lado.last.y + a.last.y)/2
  numero = lista.length+1
  puntoMed=[numero,x,y]
  mesh[0][0]= numero
  lista<< puntoMed
  return puntoMed
end


def calculateTriangle(mesh, node, triangulosArefinar) #refinacion del triangulo y calculo de los triangulos nuevos
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


def nuevosTriangulos(listaCombinacion)

  for i in 0..listaCombinacion.length-1
    for j in 0..listaCombinacion[i].length-1

    end
  end

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

  puts s.to_s

end