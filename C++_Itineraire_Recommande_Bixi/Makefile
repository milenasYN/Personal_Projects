OPTIONS=-O2 -Wall -std=c++0x 

all : tp3 chemin

tp3 : tp3.cpp coordonnee.o bixi.o carte.o
	g++ ${OPTIONS} -o tp3 tp3.cpp coordonnee.o bixi.o carte.o

chemin : chemin.cpp carte.h carte.o coordonnee.h coordonnee.o
	g++ ${OPTIONS} -o chemin chemin.cpp coordonnee.o carte.o
	
coordonnee.o : coordonnee.cpp coordonnee.h
	g++ ${OPTIONS} -c -o coordonnee.o coordonnee.cpp

bixi.o : bixi.cpp bixi.h coordonnee.h
	g++ ${OPTIONS} -c -o bixi.o bixi.cpp

carte.o : carte.cpp carte.h coordonnee.h
	g++ ${OPTIONS} -c -o carte.o carte.cpp

clean:
	rm -rf tp3 chemin *~ *.o

