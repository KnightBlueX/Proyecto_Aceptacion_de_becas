% Hechos: Alumnos, promedios, ingresos mensuales y su estado academico
alumnos(juan, 8.5, 5000, regular).
alumnos(maria, 9.2, 1000, regular).
alumnos(pedro, 7.0, 4000, regular).
alumnos(ana, 9.8, 7000, regular).
alumnos(luis, 6.5, 4500, irregular).

% Reglas: Elegibilidad por alumnos
elegible(X, 'Beca Completa') :- 
    alumnos(X, Alumnos, Ingreso, Estado),
    Alumnos >= 9.0,
    Ingreso =< 2000,
    Estado = regular.

elegible(X, 'Beca Parcial') :- 
    alumnos(X, Alumnos, Ingreso, Estado),
    Alumnos >= 8.0,
    Alumnos < 9.0,
    Ingreso =< 5000,
    Ingreso >= 3000,
    Estado = regular.

elegible(X, 'No Elegible').

% Hechos: Lista de becas
beca('Beca Completa', '\n-Nombre de la beca: Futuros Lideres \n-Descripcion: 100% de cobertura de matricula y gastos de manutencion \n-Importe: $5000 \n-Fecha de convocatoria: 14 de Febrero al 22 de Abril').
beca('Beca Completa', '\n-Nombre de la beca: Excelencia Academica \n-Descripcion: 100% de cobertura de matricula \n-Importe: $6000 \n-Fecha de convocatoria: 07 de Enero al 10 de Marzo').
beca('Beca Completa', '\n-Nombre de la beca: Innovacion y Tecnologia \n-Descripcion: Apoyo de equipo de computo gratuito \n-Importe: $5000 \n-Fecha de convocatoria: 14 de Febrero al 22 de Abril').
beca('Beca Parcial', '\n-Nombre de la beca: Talentos creativos \n-Descripcion: 50% de cobertura de matricula \n-Importe: $2500 \n-Fecha de convocatoria: 01 de Febrero al 12 de Abril').
beca('Beca Parcial', '\n-Nombre de la beca: Diversidad e inclusion \n-Descripcion: En caso de contar con discapacidad, se le ofrecera el equipo necesario \n-Importe: $4000 \n-Fecha de convocatoria: 09 de Enero al 17 Febrero').
beca('Beca Parcial', '\n-Nombre de la beca: Deportistas prometedores \n-Descripcion: Apoyo en viaticos deportivos \n-Importe: $3500 \n-Fecha de convocatoria: 14 de Febrero al 22 de Abril').

% Regla: Generar lista de becas basada en el alumnos
generar_lista_becas(X, Lista) :-
    alumnos(X, Alumnos, _, SituacionAcademica),
    elegible(X, Elegibilidad),
    beca(Elegibilidad, Descripcion),
    Lista = [Elegibilidad, Descripcion, Alumnos, SituacionAcademica].

% Hechos: Escuelas y sus becas
escuela('CUV', 'valladolid', beca_completa).
escuela('ITSVA', 'valladolid', beca_parcial).
escuela('MODELO', 'valladolid', beca_completa).
escuela('UVY', 'valladolid', beca_parcial).
escuela('UPN', 'valladolid', beca_completa).
escuela('UNO', 'valladolid', beca_parcial).
escuela('UNAM', 'ciudad_de_mexico', beca_completa).
escuela('IPN', 'ciudad_de_mexico', beca_parcial).
escuela('UAM', 'ciudad_de_mexico', beca_completa).
escuela('UDG', 'guadalajara', beca_parcial).
escuela('UANL', 'monterrey', beca_completa).
escuela('UADY', 'merida', beca_parcial).
escuela('UASLP', 'san_luis_potosi', beca_completa).
escuela('UAS', 'culiacan', beca_parcial).
escuela('UAQ', 'queretaro', beca_completa).
escuela('ITESM', 'monterrey', beca_parcial).
escuela('UACH', 'chihuahua', beca_completa).
escuela('UAG', 'guadalajara', beca_parcial).

% Regla: Buscar escuelas por ciudad y tipo de beca
buscar_escuelas(Ciudad, TipoBeca, Escuelas) :-
    findall(Escuela, (escuela(Escuela, Ciudad, TipoBeca)), Escuelas).