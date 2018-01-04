import com.iqmen.indexator.GateIndexatorClient
import com.iqmen.ise.documentmanager.DBDocument
import com.iqplatform.components.identification.IdentificationContext
import com.iqplatform.components.matching.AbstractMatchingException
import com.iqplatform.components.matching.InnerObjectMatchingResult
import com.iqplatform.components.matching.MatchingContext
import com.iqplatform.components.matching.MatchingService
import com.iqplatform.controllers.InnerObjectDao
import com.iqplatform.dictionaries.model.ThSafeDictionaryItem
import com.iqplatform.dsl.runtime.AbstractObjectDslExtensionPoint
import com.iqplatform.dsl.runtime.DSLRuntime
import com.iqplatform.dsl.runtime.DelegateWrapper
import com.iqplatform.dsl.runtime.PostSaveTriggerExecutionContext
import com.iqplatform.enums.IQProcessEnum
import com.iqplatform.model.IQObjectSet
import com.iqplatform.model.IQObjectSetImpl
import com.iqplatform.model.SingleObjectSet
import com.iqplatform.model.inner.InnerLink
import com.iqplatform.model.inner.InnerObject
import com.iqplatform.providers.lazy.LazyProvider
import com.iqplatform.services.ObjectPersistenceContext
import com.iqplatform.services.UpdateOrCreateObjectSetService
import gate.Annotation
import gate.AnnotationSet
import groovy.transform.CompileStatic
import org.apache.directory.api.util.Strings
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Required

import javax.annotation.Nonnull
import javax.annotation.Nullable

import static com.iqplatform.gate.GateConstants.ANNOTATION_SET_NAME

/**
 * Created by yarovoy on 19.10.2015.
 * Скрипт выделяет места работы и учебы из различных атрибутов персоны и достраивает связи между этой персоной и выделенными
 * юр. лицами.
 **/
@SuppressWarnings("GroovyUnusedDeclaration")
class ExpertPostPersist extends AbstractObjectDslExtensionPoint {
    final Logger logger = LoggerFactory.getLogger('ExpertPostPersist')

    @Autowired
    GateIndexatorClient gateIndexatorClient

    @Autowired
    DSLRuntime dslRuntime

    /*DossierPersonRankService dossierPersonRankService*/

    @Autowired
    LazyProvider<UpdateOrCreateObjectSetService> updateOrCreateObjectSetServiceLazyProvider

    @Autowired
    LazyProvider<MatchingService> matchingServiceLazyProvider

    private InnerObjectDao objectDao

    void init() {
        logger.info('[init]')
    }

    @Override
    Void invoke(@Nonnull InnerObject expertIn, @Nonnull ObjectPersistenceContext persistenceContext, Object[] args) {

        try {
            PostSaveTriggerExecutionContext context = (PostSaveTriggerExecutionContext) DSLRuntime.context
            DelegateWrapper wrapper = new DelegateWrapper(expertIn, dslRuntime, [:])

            String aboutText = expertIn.get('About')
            String universitiesText = expertIn.get('ExpertUni')
            String orgsText = expertIn.get('ExpertOrgs')


            final List<InnerObject> universities = []
            final List<InnerObject> companies = []
            final List<InnerObject>[] array = [universities, companies] as List<InnerObject>[]
            final Closure closure = { List<InnerObject> it, int i -> array[i].addAll(it) }

            analyzeAttribute(aboutText, ['docType': 'bio'], wrapper).eachWithIndex(closure)
            analyzeAttribute(universitiesText, ['docType': 'edu'], wrapper).eachWithIndex(closure)
            analyzeAttribute(orgsText, ['docType': 'work'], wrapper).eachWithIndex(closure)

            final ObjectPersistenceContext coercedPersistenceContext = ObjectPersistenceContext.newAutoContext(IQProcessEnum.OBJECT_POST_PROCESSING)
            final IdentificationContext identificationContext = IdentificationContext.newInstance().setObjectPersistenceContext(coercedPersistenceContext)

            for (InnerObject univer in universities) {
                /*if (expertIn.SourceType) {
                    univer.SourceType ? univer.SourceType.addAll(expertIn.SourceType) : (univer.SourceType = expertIn.SourceType)
                }*/
                updateOrCreate(univer, identificationContext)
                if (univer.id) {
                    def link = context.newLink('WorkedIn', expertIn, univer)
                    updateOrCreate(link, identificationContext)
                }
            }

            for (InnerObject company in companies) {
                /*if (expertIn.SourceType) {
                    company.SourceType ? company.SourceType.addAll(expertIn.SourceType) : (company.SourceType = expertIn.SourceType)
                }*/
                updateOrCreate(company, identificationContext)
                if (company.id) {
                    def link = context.newLink('StudiedAt', expertIn, company)
                    updateOrCreate(link, identificationContext)
                }
            }
            return null
        } catch (Throwable ex) {
            logger.error(ex.toString(), ex)
            throw ex
        }
    }

    @Nonnull
    @CompileStatic
    private List<InnerObject>[] analyzeAttribute(@Nonnull String attribute, @Nonnull Map features, @Nonnull DelegateWrapper wrapper) {
        try {
            if (attribute) {
                DBDocument dbDoc = gateIndexatorClient.processText(attribute, features, 'orgsDescription', 1000000)
                try {
                    if (dbDoc) {
                        //noinspection UnnecessaryQualifiedReference
                        gate.Document gateDoc = dbDoc.gateDocument
                        return extractObjects(gateDoc, wrapper)
                    }
                } finally {
                    DBDocument.cleanGateDocument(dbDoc)
                }
            }
        } catch (Throwable ex) {
            logger.error(ex.getMessage(), ex)
        }
    }

    @CompileStatic
    private void updateOrCreate(@Nonnull InnerObject model, IdentificationContext context) {
        IQObjectSet objectSet = new SingleObjectSet(model)
        def updateOrCreateObjectSetService = updateOrCreateObjectSetServiceLazyProvider.instance
        updateOrCreateObjectSetService.updateOrCreate(objectSet, context)
    }

    @CompileStatic
    @Nullable
    private InnerObject tryFind(@Nonnull InnerObject model) {
        try {
            MatchingService matchingService = matchingServiceLazyProvider.instance
            InnerObjectMatchingResult matchingResult = matchingService.findMatch(model, MatchingContext.debug())
            if (matchingResult.match) {
                return matchingResult.match
            } else {
                return null
            }
        } catch (AbstractMatchingException ignored) {
            logger.warn(ignored.toString())
            return null
        }
    }

    @CompileStatic
    private void updateOrCreate(@Nonnull InnerLink model, IdentificationContext context) {
        IQObjectSetImpl objectSet = new IQObjectSetImpl(model.left)
        objectSet.addLink(model, false, true)
        def updateOrCreateObjectSetService = updateOrCreateObjectSetServiceLazyProvider.instance
        updateOrCreateObjectSetService.updateOrCreate(objectSet, context)
    }

    @SuppressWarnings("UnnecessaryQualifiedReference")
    @Nonnull
    private List<InnerObject>[] extractObjects(@Nonnull gate.Document doc, @Nonnull DelegateWrapper wrapper) {
        List<InnerObject> universities = []
        List<InnerObject> companies = []

        Closure<ThSafeDictionaryItem> dict = { String value ->
            return dslRuntime.dict('OrganizationType', 'OrganizationType', value)
        }

        final Map<String, Closure<InnerObject>> schemas = [
            'OrgDossier'   : { Annotation ann ->
                return context.newObject('OrgDossier', [name: ann.features.name, fromBio : true])
            },
            'WorldOrg'     : { Annotation ann ->
                return context.newObject('WorldOrg', [name: ann.features.name, fromBio : true])
            },
            'StateOrg'     : { Annotation ann ->
                return context.newObject('StateOrg', [name: ann.features.name, fromBio : true])
            },
            'SpecialForces': { Annotation ann ->
                return context.newObject('SpecialForces', [name: ann.features.name, fromBio : true])
            },
            'TerrorOrg'    : { Annotation ann ->
                return context.newObject('TerrorOrg', [name: ann.features.name, fromBio : true])
            }
        ]

        AnnotationSet annotationSet = doc.getAnnotations(ANNOTATION_SET_NAME)
        PostSaveTriggerExecutionContext context = (PostSaveTriggerExecutionContext) DSLRuntime.context
        for (Annotation annotation in annotationSet) {

            logger.info('annotation type: {}\tfeatures:\n{}', annotation.type, annotation.features)

            if (annotation.type == 'EduOrganization' || annotation.type == 'WorkOrganization') {
                InnerObject org = null

                String name = annotation.features.name

                if (Strings.isNotEmpty(name)) {
                    logger.error('Organization has no name: {}', annotation)
                    continue
                }

                /** цикл в попытке найти объект **/
                for (Map.Entry<String, Closure> it : schemas.entrySet()) {
                    String string = it.key
                    Closure<InnerObject> closure = it.value
                    InnerObject obj = closure(string)
                    if (obj) {
                        break
                    }
                }

                if (obj == null) {
                    
                    String type = annotation.features.type
                    String wiki = annotation.features.wiki

                    if (type == 'massmedia') {
                        org = context.newObject('OrgDossier', [name: name, OrgType: dict('СМИ, издательское дело'), URL_WikiEn: wiki,fromBio : true])
                    } else if (type == 'GOV') {
                        org = context.newObject('StateOrg', [name: name, fromBio : true])
                    } else if (type == 'thinktank') {
                        org = context.newObject('OrgDossier', [name: name, OrgType: dict('Think Tank'), URL_WikiEn: wiki, fromBio : true])
                    } else if (type == 'IA') {
                        org = context.newObject('SpecialForces', [name: name, fromBio : true])
                    } else {
                        logger.warn('unexpected organization type: {}', type)
                    }
                }

                if (org) {
                    if (annotation.type == 'EduOrganization') {
                        universities << org
                    } else {
                        companies << org
                    }
                }
            }
        }
        return [universities, companies] as List<InnerObject>[]
    }

    @Required
    void setObjectDao(InnerObjectDao objectDao) {
        this.objectDao = objectDao
    }
}