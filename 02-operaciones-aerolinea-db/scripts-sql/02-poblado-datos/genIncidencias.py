#####################################################################
#                                                                   #
# ESTE PROGRAMA SIRVE PARA GENERAR LAS INCIDENCIAS DE CADA VUELO    #
# LUEGO HAY QUE SEPARARLAS EN SUS RESPECTIVOS ARCHIVOS CSV          #
#                                                                   #
#####################################################################

import pandas as pd

input_file = "DatosVuelo.csv"
output_file = "output.csv"

# carga el archivo csv
df = pd.read_csv(input_file, delimiter=";", header=0, dtype=object)

# lista con las filas del nuevo CSV
new_rows = []

# Identificador de cada incidencia
id_incidencia = 1


# Genera una linea nueva en el archivo de salida
def createNewRow(
    id_inc,
    flight_date,
    flight_num,
    crs_dep_time,
    cancel_cause="",
    retraso_cause="",
    retraso_delay="",
    desvio_iata="",
    desvio_delay="",
):
    row = {
        "ID_incidence": id_inc,
        "flightDate": flight_date,
        "flightNum": flight_num,
        "crsDepTime": crs_dep_time,
        "cancellationName": cancel_cause,
        "retrasoCause": retraso_cause,
        "retrasoDelay": retraso_delay,
        "desvioIata": desvio_iata,
        "desvioDelay": desvio_delay,
    }

    new_rows.append(row)


for _, row in df.iterrows():
    # Por cada incidencia encontrada añade una nueva fila al archivo de salida

    if row["cancelled"] != "0" and row["cancelled"].strip() != "":
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            cancel_cause=row["cancellationName"],
        )

        id_incidencia += 1
        continue  # Dado que no puede haber otro tipo de incidencia si se cancela. Salto el bucle

    if row["diverted"] != "0" and row["diverted"].strip() != "":
        if pd.isnull(row["divArrDelay"]):
            row["divArrDelay"] = "0"

        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            desvio_iata=row["div1airport"],
            desvio_delay=row["divArrDelay"],
        )
        id_incidencia += 1

        if pd.notnull(
            row["div2airport"]
        ):  # Comprobamos si se desvia una segunda vez
            createNewRow(
                id_incidencia,
                row["flightDate"],
                row["flightNum"],
                row["crsDepTime"],
                desvio_iata=row["div2airport"],
                desvio_delay="0",
            )
            id_incidencia += 1

    if row["carrierDelay"] != "0" and row["carrierDelay"].strip() != "":
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            retraso_cause="Carrier",
            retraso_delay=row["carrierDelay"],
        )
        id_incidencia += 1

    if row["weatherDelay"] != "0" and row["weatherDelay"].strip() != "":
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            retraso_cause="Weather",
            retraso_delay=row["weatherDelay"],
        )
        id_incidencia += 1

    if row["nasDelay"] != "0" and row["nasDelay"].strip() != "":
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            retraso_cause="NAS",
            retraso_delay=row["nasDelay"],
        )
        id_incidencia += 1
    if row["securityDelay"] != "0" and row["securityDelay"].strip() != "":
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            retraso_cause="Security",
            retraso_delay=row["securityDelay"],
        )
        id_incidencia += 1
    if (
        row["lateAircraftDelay"] != "0"
        and row["lateAircraftDelay"].strip() != ""
    ):
        createNewRow(
            id_incidencia,
            row["flightDate"],
            row["flightNum"],
            row["crsDepTime"],
            retraso_cause="LateAircraft",
            retraso_delay=row["lateAircraftDelay"],
        )
        id_incidencia += 1

# Guardamos los datos en el nuevo archivo
df_new = pd.DataFrame(new_rows)
df_new.to_csv(output_file, index=False, sep=";")
