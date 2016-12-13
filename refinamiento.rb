def coordenadas()
  node = []
  File.open('espiral.node','r') do |f|
    while linea = f.gets
      node << linea.chop!
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
  File.open('espiral.mesh','r') do |f|
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
    distancias = Math.sqrt((primero**2)+(segundo**2)).to_f
    return distancias
end



def angulosTriangulos(a,b,c)
  angulo = 57.2958
  alfa = (angulo)*Math.acos(((c**2)+(b**2)-(a**2))/(2*b*c))
  beta = (angulo)*Math.acos(((a**2)+(c**2)-(b**2))/(2*a*c))
  gama= (angulo)*Math.acos(((a**2)+(b**2)-(c**2))/(2*a*b))
  refinar = 0
  if (alfa <= 18 || beta <= 18 || gama <= 18)
    refinar = 1
  end
#  puts (alfa).to_s+"---"+(beta).to_s+"  ---- "+(gama).to_s
  return refinar
end

def cantidadDeTriangulos(mesh)
  largo = mesh[0][0]
  return largo
end


listaa =[]
listab=[]
listac=[]
largo= cantidadDeTriangulos(mesh)
lista =[]
for j in 1..largo
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
