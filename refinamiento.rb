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

def distancia(c,d)
    primero = d[1]-c[1]
    segundo = d[2]-c[2]
    distancias = Math.sqrt((primero**2)+(segundo**2)).to_f #math.sqrt calcula raiz cuadrada
    return distancias
end



def angulosTriangulos(a,b,c)
  angulo = 180/Math::PI
  bCuadrado= b*b
  cCuadrado = c*c
  aCuadrado = a*a
  alfa = Math.acos((bCuadrado+cCuadrado- aCuadrado)/(2*b*c))* angulo
  beta = Math.acos((aCuadrado+cCuadrado- bCuadrado )/(2*a*c))*angulo
  gama = Math.acos((aCuadrado+bCuadrado-cCuadrado)/(2*a*b))*angulo
  refinar = 0
  if (alfa <= 18 || beta <= 18 || gama <= 18)
    refinar = 1
  end
  puts (alfa).to_s+"---"+(beta).to_s+"  ---- "+(gama).to_s
  return refinar
end


def cantidadDeTriangulos(mesh)
  largo = mesh[0][0]
  return largo
end


def angulo(a,b,c)
  gama=Math.acos((c*c-a*a-b*b)/(-2*a*b))*180/Math::PI
  alfa=Math.acos((a*a-b*b-c*c)/(-2*b*c))*180/Math::PI
  beta=Math.acos((b*b-a*a-c*c)/(-2*a*c))*180/Math::PI

  refinar = 0
  if (alfa <= 18 || beta <= 18 || gama <= 18)
    refinar = 1
  end
  puts (alfa).to_s+"---"+(beta).to_s+"  ---- "+(gama).to_s
  return refinar

end

largo= cantidadDeTriangulos(mesh)
lista =[]
segunda = []
for j in 1..largo
  a=0
  b=0
  c=0
  for i in 0..node.length-1
    if mesh[j][0]==node[i][0]
      largo1 = node[i]
    end

    if mesh[j][1]==node[i][0]
      largo2  = node[i]
    end

    if mesh[j][2]==node[i][0]
      largo3 = node[i]
    end
  end
  a= distancia(largo1,largo2)
  b=distancia(largo2,largo3)
  c=distancia(largo1,largo3)
  lista << angulosTriangulos(a,b,c)
end

def triagulosArefinar(refinar) #aca se vera el numero del triangulo a refinar  
  lista=[]
  for i in 0..refinar.length-1
    if refinar[i]==1
      lista<<i+1   
    end
  end    
  return lista
end 

def puntoMedio(a, b) #calcula el punto medio de una distancia
    primero = (b[1]-a[1])/2
    segundo = (b[2]-a[2])/2
    puntoMed=[primero,segundo]
  return puntoMed  
end

def calculateTriangle(mesh, node, triangulosArefinar) #refinacion del triangulo y calculo de los triangulos nuevos
  nuevo= []
  for i in 0..triangulosArefinar.length-1
      nuevo<<mesh[triangulosArefinar[i]]
      for j in 0..nuevo.length-1

      end

  end 
end