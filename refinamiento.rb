
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
    distancias = Math.sqrt(((d[1]-c[1])**2)+((d[2]-c[2])**2))
    return distancias
end
