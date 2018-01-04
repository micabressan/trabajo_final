postUpdate.add({
    def persistence = AppBeans.get(Persistence.NAME)

    def tx = persistence.createTransaction()
    try {
        def em = persistence.getEntityManager()
        em.setSoftDeletion(false)

        em.createQuery('select d from swemel$SwemelDoc d')
                .getResultList()
                .each { def swemelDoc ->
            for (def medoParcel : swemelDoc.getMedoParcels()) {
                if (medoParcel.getDeleteTs() == null) {
                    def medoStatus = null

                    switch (swemelDoc.getDocType()) {
                        case DocTypeEnum.OUTCOME:
                            medoStatus = MedoDocStatusEnum.SENT_TO_MEDO
                            break
                        case DocTypeEnum.INCOMING:
                            medoStatus = MedoDocStatusEnum.RECEIVED_FROM_MEDO
                            break
                    }

                    swemelDoc.setMedoStatus(medoStatus)
                    break
                }
            }
        }

        tx.commit()
    } finally {
        tx.end()
    }
})