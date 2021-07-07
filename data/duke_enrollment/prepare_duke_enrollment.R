library(tidyverse)

duke_enrollment <- read_csv('data/duke_enrollment/UberMegaMaster_70S-20F-V5.csv') %>%
  dplyr::select(-X1, -X.2, -X.1, -X)

duke_enrollment_by_status <- duke_enrollment %>%
  dplyr::select(Year, Semester, Origin, Region, Sex, All_UG, All_Grad) %>%
  rename("Undergraduate" = "All_UG", "Graduate" = "All_Grad") %>%
  pivot_longer(cols = c(Undergraduate, Graduate),
               names_to = "Student_Status",
               values_to = "Count") %>%
  dplyr::filter(Count > 0)

duke_enrollment_by_school <- duke_enrollment %>%
  dplyr::select(Year, Semester, Origin, Region, Sex, Trinity, Nursing,
                Engineering, Graduate, Divinity, Law, Business, Environment,
                Medicine, Graduate.Nursing, Allied.Health) %>%
  pivot_longer(cols = c(Trinity, Nursing, Engineering, Graduate, Divinity, Law,
                        Business, Environment, Medicine, Graduate.Nursing,
                        Allied.Health), names_to = "School", values_to = "Count") %>%
  dplyr::filter(Count > 0)

write_csv(duke_enrollment_by_status, "data/duke_enrollment/duke_enrollment_by_status.csv")
write_csv(duke_enrollment_by_school, "data/duke_enrollment/duke_enrollment_by_school.csv")
