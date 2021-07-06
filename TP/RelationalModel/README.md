# **Relational Model**

## 1.
### A)
 > {S#, V, N, A}+ = {S#, V, N, A, S, Y, M, R, E, I, C}
 > Como o fecho de X não inclui todos os atributos de REFS, X não é uma chave para REFS. As X's closure does not include all atributes of REFS, X is not a key of REFS

### B)
> **PASSO 1**			    
> | FDs                 | CLOSURES (by other FDs)
> |---------------------|-------------------------------------------------------
> | S -> S#			    |   { S }+ = { S, R, E } 
> | S -> R			    |	{ S }+ = { S, S#, E }
> | S -> E			    |	{ S }+ = { S, S#, R }
> | S# ->  S			|	{ S# }+ = { S# }
> | S, V, N -> Y		|	{ S, V, N }+ = { S, V, N, S#, R, E, M }
> | S, V, N -> M		|	{ S, V, N }+ = { S, V, N, S#, R, E, Y }
> | S, V, N, PI -> T	|	{ S, V, N, PI }+ = { S, V, N, PI, PF, S#, R, E, M, Y }
> | S, V, N, PI -> PF	|	{ S, V, N, PI }+ = { S, V, N, PI, T, S#, R, E, M, Y }
> | A -> I		    	|	{ A }+ = { A, C }
> | A -> C	            |   { A }+ = { A, I }
> 
> Não há FDs redundantes  No redundant FDs
> Não há atributos do lado esquerdo redundantes No redundant left-side attributes  
> G = D (being D the set of original FDs and G the new one)
> 
> **PASSO 2**      
> | RELATIONS                 |   FDs                         
> |---------------------------|----------------------------
> | R1 (S, S#, R, E)	      |   S -> S#, R, E
> | R2 (S#, S)		          |   S# -> S
> | R3 (S, V, N, Y, M)	      |   S, V, N -> Y, M
> | R4 (S, V, N, PI, T, PF)	  |   S, V, N, PI -> T, PF
> | R5 (A, I, C)		      |   A -> I, C
> | R6 (A, V, N, S, PI)       | KEY

### C)
> The 3rd Normal Form reduces redundancy while effectively maintaining data integrity and dependency preservation. The database becomes smaller in size due to its lack of redundancy, thus improving its performance.

### D)

> Revista (S, S#, R, E)  
> FDs:
>  - S->S#, R, E
>  - S#->S  
> 
> | S   | S#  | R  | E
> |-----|-----|-----|---
> |a    |b	  |c    |d
> |x	|b	  |c    |d
> 
> The table shows that even in 3rd Normal Form, redundancy is possible. To avoid such situations, the SGBD must support some kind of unicity restrictions to define the candidate keys

### E)
> It is, because the left side of the relations is a superkey (if a relation is in 3NF, it is also in BCNF)

## 2.
### A)
> - ABE 

### B)
>  |  R  |  A  |  B    |  C    |  D    |  E    |
>  |-----|-----|-------|-------|-------|-------|
>  |  R1 | A   |  B    |   C   |   D   |  E1   |
>  |  R2 |  A2 |   B2  |   C   |   D   |   E   |
>  |  R3 |  A3 |   B   |   C3  |   D   |  E3   |
> 
> This decompositions does not ensure lossless join, proven by the Chase Test

### C)
>  |  R  |  A  |  B    |  C    |  D    |  E    |
>  |-----|-----|-------|-------|-------|-------|
>  |  R1 |  A  |   B   |   C   |   D   |   E1  |
>  |  R2 |  A2 |   B2  |   C   |   D   |   E   |
>  |  R3 |  A3 |   B   |   C3  |   D   |   E3  |
>  |  R4 |  A  |   B   |   C   |   D   |   E   |
> 
> This decomposition now ensures lossless join, proven by the chase test

### D)
> **PASSO 1**			    
> | FDs                 | CLOSURES (by other FDs)
> |---------------------|-------------------------------------------------------
> | A, B -> C		    |   { A, B }+ = { A, B, D} 
> | D, E -> C    	    |	{ D, E }+ = { D, E }
> | B -> D   		    |	{ B }+ = { B }
> 
> Não há FDs redundantes  No redundant FDs
> Não há atributos do lado esquerdo redundantes No redundant left-side attributes  
> G = D (being D the set of original FDs and G the new one)
> 
> **PASSO 2**      
> | RELATIONS                 |   FDs                         
> |---------------------------|----------------------------
> | R1 (A, B, C)	          |   A, B -> C
> | R2 (D, E, C)		      |   D, E -> C
> | R3 (B, D)	              |   B -> D
> | R4 (A, B, E)              |   KEY

### E)
> | SETS          |   CLOSURES                        
> |---------------|----------------------------
> | A	          |   {A}+ =  {A, D}
> | B		      |   {B}+ = {B}
> | C	          |   {C}+ = {C}
> | AB            |   {A, B}+ = {A, B, E, D}
> | AC	          |   {A, C}+ = {A, C, E, B, D}
> | BC		      |   {B, C}+ = {B, C}
> 
> **R:** A, C -> B

## 3.
### A)
> **R:** {J, D, Q, V}, {J, D, Q, V, S}, {J, D, Q, V, S, P}, {J, D, Q, V, P}, {J, D, Q, V, S, C}, {J, D, Q, V, C}, {J, D, Q, V, S, P, C}, {J, D, Q, V, C, P}

### B)
> A decomposição não se econtra na 3NF porque R3 não cumpre as regras estabelecidas por esta forma normal. Em R3, infere-se que a chave é J, D, Q, V -> C. No entanto, Q e V são irrelevantes, visto que J, D -> C. Isto vai contra as leis da 3NF, pois Q e V são atributos redundantes.
> 
> **PASSO 1**			    
> | FDs                 | CLOSURES (by other FDs)
> |---------------------|-------------------------------------------------------
> | J, P -> C		    |   { J, P }+ = { J, P, S } 
> | S, D -> P    	    |	{ S, D }+ = { S, D }
> | J -> S   		    |	{ J }+ = { J }
> 
> Não há FDs redundantes  No redundant FDs
> Não há atributos do lado esquerdo redundantes No redundant left-side attributes  
> G = D (being D the set of original FDs and G the new one)
> 
> **PASSO 2**      
> | RELATIONS                 |   FDs                         
> |---------------------------|----------------------------
> | R1 (J, P, C)	          |   J, P -> C
> | R2 (S, D, P)		      |   S, D -> P 
> | R3 (J, S)	              |   J -> S
> | R4 (J, V, D, Q)           |   KEY

### C)
> It is not preserved, given the 3 attributes are not present in the same relation

### D)
> | FDs                 | CLOSURES (by other FDs)
> |---------------------|-------------------------------------------------------
> | J, P -> C		    |   { J, P }+ = { J, P, S } 
> | S, D -> P    	    |	{ S, D }+ = { S, D }
> | J -> S   		    |	{ J }+ = { J }
> | C -> S              |   { C }+ = { C, J, D, P, Q, V, S }
> | C -> J              |   { C }+ = { C, S, D, P, Q, V }
> | C -> D              |   { C }+ = { C, S, J, P, Q, V } 
> | C -> P              |   { C }+ = { C, S, J, D, Q, V, P }
> | C -> Q              |   { C }+ = { C, S, J, D, P, V }
> | C -> V              |   { C }+ = { C, S, J, D, P, Q }
> | C -> C              |   { C }+ = { C, S, J, D, P, Q, V }
> 
> Three of the FDs are irrelevant
>
> **R:** J, P -> C; S, D -> P; J -> S; C -> J, D, Q, V 

## 4.
### A)
> **R:** C -> P;
> S, H -> C; 
> P, H -> S; 
> A, C -> N; 
> A, H -> S

### B)
> **R:** {H, A}

### C)
> **PASSO 1**
> | FDs                 | CLOSURES (by other FDs)
> |---------------------|-------------------------------------------------------
> | S, H -> C			|   { S, H }+ = { S, H } 
> | C -> P			    |	{ C }+ = { C }
> | P, H -> S			|	{ P, H }+ = { P, H }
> | A, C -> N			|	{ A, C }+ = { A, C, P }
> | A, H -> S	 	    | 	{ A, H }+ = { A, H }
>
> Não há FDs redundantes  No redundant FDs
> Não há atributos do lado esquerdo redundantes No redundant left-side attributes  
> G = D (being D the set of original FDs and G the new one)
> **PASSO 2**
> | RELATIONS           | FDs
> |---------------------|----------------------
> | R1(S, H, C)         | S, H -> C
> | R2(C, P)            | C -> P
> | R3(P, H, S)         | P, H -> S
> | R4(A, C, N)         | A, C -> N
> | R5(A, H, S)         | A, H -> S (superkey)

### D)
> **R:** Todas se encontram na BCNF visto que todos os atributos do lado direito das FDs são super chaves das relações
