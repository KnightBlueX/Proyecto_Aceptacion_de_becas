#Nombre de los alumnos: 
#Fernando Javier Noh Requena   | 19070052
#Wiliam Santiago Sierra Guemez | 19070018
#Alejandro Caamal Poot         | 19070014
#Evan Jazheel Ku Canche        | 19070048

#Nombre del docente: M.M.M.D José Leonel Pech May

#Líbrería a usar para el puente con prolog: 
from pyswip import Prolog

def consultar_becas():
    prolog = Prolog()
    try:
        prolog.consult("becas.pl")  # Carga el archivo Prolog
    except Exception as e:
        print("Error al cargar el archivo Prolog:", e)
        return

    while True:
        print("Seleccione el tipo de consulta:")
        print("1. Evaluación de Elegibilidad para Beca")
        print("2. Recomendación de beca")
        print("3. Buscador de escuelas")
        print("4. Salir")

        try:
            opcion = int(input("Ingrese el número de la consulta deseada: "))
        except ValueError:
            print("Opción inválida. Por favor, ingrese un número válido (1, 2, 3 o 4).")
            continue

        if opcion == 1:
            alumno = input("Ingrese el nombre del alumno: ")
            consulta_elegibilidad_completa = f"elegible({alumno}, 'Beca Completa')"
            elegible_completa = bool(list(prolog.query(consulta_elegibilidad_completa)))
            consulta_elegibilidad_parcial = f"elegible({alumno}, 'Beca Parcial')"
            elegible_parcial = bool(list(prolog.query(consulta_elegibilidad_parcial)))

            if elegible_completa:
                print(f"Usted es elegible para recibir una beca completa.")
            elif elegible_parcial:
                print(f"Usted es elegible para recibir una beca parcial.")
            else:
                print(f"Usted no cumple con los requisitos para recibir una beca.")
            pass
        elif opcion == 2:
            alumno = input("Ingrese el nombre del alumno: ")
            consulta_recomendacion = f"generar_lista_becas({alumno}, Lista)"
            becas_encontradas = list(prolog.query(consulta_recomendacion))
            if becas_encontradas:
                print(f"Usted es elegible para las siguientes becas:")
                for beca in becas_encontradas:
                    elegibilidad = beca['Lista'][0]
                    descripcion = beca['Lista'][1]
                    #promedio = beca['Lista'][2]
                    #situacion_academica = beca['Lista'][3]
                    print("==================================================================================")
                    print(f"Tipo de beca: {elegibilidad}")
                    print(f"Datos de la beca: {descripcion}")
                    #print(f"Promedio: {promedio}")
                    #print(f"Situación Académica: {situacion_academica}")
                    print(" ")
            else:
                print(f"Usted no cumple con los requisitos para recibir una beca.")

            pass
        elif opcion == 3:
            ciudad = input("Ingrese la ciudad: ")
            tipo_beca = input("Ingrese el tipo de beca: ")

            consulta_escuelas = f"buscar_escuelas('{ciudad}', '{tipo_beca}', Escuelas)"
            escuelas = list(prolog.query(consulta_escuelas))

            if escuelas:
                print(f"Las escuelas con beca en {ciudad} y el tipo de beca '{tipo_beca}' son:")
                for resultado in escuelas:
                    for nombre_escuela in resultado['Escuelas']:
                        print(nombre_escuela)
            else:
                print(f"No se encontraron escuelas con beca en {ciudad} y el tipo de beca '{tipo_beca}'.")
        elif opcion == 4:
            print("Saliendo del programa...")
            break
        else:
            print("Opción inválida. Por favor, ingrese un número válido (1, 2, 3 o 4).")

        print("\n")

consultar_becas()
