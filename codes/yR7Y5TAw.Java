package com.nguyen.training.spring;


import com.nguyen.training.spring.entity.Event;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.SchemaOutputResolver;
import javax.xml.transform.Result;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.IOException;

/**
 * @author the_viet_nguyen
 */
public class JaxbUtils {

    public static void generateSchema(Class<?> clazz, String path) throws JAXBException, IOException {
        JAXBContext jaxbContext = JAXBContext.newInstance(clazz);
        SchemaOutputResolver sor = new SimpleSchemaOutputResolver(path);
        jaxbContext.generateSchema(sor);
    }

    private static class SimpleSchemaOutputResolver extends SchemaOutputResolver {

        private String targetPath;

        public SimpleSchemaOutputResolver(String targetPath) {
            this.targetPath = targetPath;
        }

        @Override
        public Result createOutput(String namespaceUri, String suggestedFileName) throws IOException {
            File file = new File(targetPath);
            StreamResult result = new StreamResult(file);
            result.setSystemId(file.toURI().toURL().toString());
            return result;
        }
    }

}