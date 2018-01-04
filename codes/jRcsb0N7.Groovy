postUpdate.add({
    def persistence = AppBeans.get(Persistence.NAME)

    def tx = persistence.createTransaction()
    try {
        EntityManager em = persistence.getEntityManager()

        em.createQuery('select c from wf$CardRole c where c.procRole.proc.code = \'DistributionNew\'\' and c.code = \'Responsible\'',
        CardRole.class)
                .getResultList()
                .each { CardRole cardRole ->
            ((SwemelDoc)cardRole.getCard()).setResponsible(cardRole.getUser())
        }

        tx.commit()
    } finally {
        tx.end()
    }
})