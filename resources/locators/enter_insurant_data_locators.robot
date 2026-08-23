*** Variables ***

# Locators da etapa "Enter Insurant Data".
${INSURANT_DATA_TAB}    id=enterinsurantdata
${INSURANT_DATA_NEXT_BUTTON}    id=nextenterproductdata
${FIRST_NAME_INPUT}    id=firstname
${LAST_NAME_INPUT}    id=lastname
${BIRTH_DATE_INPUT}    id=birthdate
${MALE_GENDER_INPUT}    id=gendermale
${MALE_GENDER_RADIO}    xpath=//input[@id='gendermale']/following-sibling::span[1]
${STREET_ADDRESS_INPUT}    id=streetaddress
${COUNTRY_SELECT}    id=country
${ZIP_CODE_INPUT}    id=zipcode
${CITY_INPUT}    id=city
${OCCUPATION_SELECT}    id=occupation
${SPEEDING_CHECKBOX}    xpath=//input[@id='speeding']/following-sibling::span[1]
