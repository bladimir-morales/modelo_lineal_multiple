library(readxl)
library(writexl)

bd_pob<-read_xlsx("./data/crecimiento_poblacion.xlsx",sheet = "Data") %>%
  dplyr::select(pais,codigo,variable,"2018") %>%
  pivot_wider(names_from = variable,values_from = "2018")

bd_pob1<-bd_pob %>%
  filter(!codigo %in% c("KWT")) %>%
  dplyr::select(pais,codigo,
                esp_vida="Esperanza de vida al nacer, total (años)",
                mortalidad_varones="Tasa de mortalidad, adultos, varones (por cada 1.000 varones adultos)",
                fertilidad="Tasa de fertilidad, total (nacimientos por cada mujer)",
                superficie="Superficie (kilómetros cuadrados)",
                mortalidad_mujeres="Tasa de mortalidad, adultos, mujeres (por cada 1.000 mujeres adultas)",
                crecimiento_pib="Crecimiento del PIB (% anual)",
                acceso_electricidad="Acceso a la electricidad (% de población)",
                desempleo="Desempleo, total (% de la población activa total) (estimación modelado OIT)" ,
                co2="Emisiones de CO2 (kt)",
                metano="Emisiones de metano (kt de equivalente de CO2)",
                oxido_nitroso="Emisiones de óxido nitroso (miles de toneladas métricas de equivalente de CO2)",
                gasto_educacion="Gasto público en educación, total (% del PIB)",
  ) %>%
  mutate(mortalidad=(mortalidad_varones+mortalidad_mujeres)/2) %>%
  dplyr::select(-mortalidad_varones,-mortalidad_mujeres) %>%
  filter_if(is.numeric,all_vars(!is.na(.)))

writexl::write_xlsx(bd_pob1,"./data/bd_poblacion.xlsx")
