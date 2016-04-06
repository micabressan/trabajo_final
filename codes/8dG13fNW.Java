package com.arkasoft.cloudfs.rest;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;

import com.arkasoft.cloudfs.Constants;
import com.arkasoft.cloudfs.StoreObjectsBean;
import com.arkasoft.cloudfs.UsersBean;
import com.arkasoft.cloudfs.dao.DAO;
import com.arkasoft.cloudfs.entity.StoreObject;
import com.arkasoft.cloudfs.entity.User;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.services.storage.Storage;
import com.google.api.services.storage.model.StorageObject;

@Stateless
@Path("objects")
@Produces("application/json")
public class StoreObjectRest implements Constants {
	
	private static final String ROOT_PATH = "root";

	@EJB
	private DAO dao;

	@EJB
	private UsersBean usersBean;

	@EJB
	private StoreObjectsBean storeObjectsBean;

	@Context
	private HttpServletRequest request;
	
	@Context
	private HttpServletResponse response;
	
	@GET
	@Path("{path:.*}")
	public String getObjects(@PathParam("path") String path, @QueryParam("sortBy") String sortBy) {
		path = sanitize(path);
		System.out.println(">>> getObjects: " + path + ", sortBy: " + sortBy);
		
		final User user = getUser();
		final StoreObject parent = storeObjectsBean.getStoreObject(user, path);
		
		System.out.println("\tParent: " + parent);
		
		// TODO: maybe synchronize with getTree
		List<StoreObject> objects = storeObjectsBean.getObjects(user, parent, sortBy);
		
		//
		// Convert to DojoStore
		//
		
		String jsonStr = null;
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for (StoreObject o : objects) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", StoreObjectsBean.makeStoreObjectPublicId(user, o.getId()));
			map.put("name", o.getName());
			map.put("updated", o.getUpdated());
			map.put("contentType", o.isFolder() ? "Folder" : o.getContentType());
			if (!o.isFolder()) {
				map.put("size", o.getSize());
			}
			list.add(map);
		}
		jsonStr = GSON.toJson(list);
		
		// GridX needs "Content-Range" header to show items.
		final int items = list.size();
		response.setHeader("Content-Range", String.format("%d-%d/%d", 0, items, items));
		
		return jsonStr;
	}
	
	@PUT
	@Path("{path:.*}")
	@Consumes("application/json")
	public String updateObject(@PathParam("path") String path, String jsonStr) {
		path = sanitize(path);
		System.out.println(">>> updateObject: " + path);
		
		final User user = getUser();
		
		@SuppressWarnings("unchecked")
		Map<String, Object> map = GSON.fromJson(jsonStr, Map.class);
		System.out.println("map: " + map);
		
		String id = (String) map.get("id");
		String name = (String) map.get("name");
		String updated = (String) map.get("updated");
		String contentType = (String) map.get("contentType");
		Double size = (Double) map.get("size");
		
		final StoreObject parent = storeObjectsBean.getStoreObject(user, (String) map.get("parent"));
		
		StoreObject o = storeObjectsBean.update(StoreObjectsBean.makeStoreObjectId(user, id), name, updated, contentType, size, user, parent, false);
		
		map = new HashMap<String, Object>();
		map.put("id", StoreObjectsBean.makeStoreObjectPublicId(user, o.getId()));
		map.put("name", o.getName());
		map.put("updated", o.getUpdated());
		map.put("contentType", o.isFolder() ? "Folder" : o.getContentType());
		map.put("size", o.getSize());
		
		jsonStr = GSON.toJson(map);

		return jsonStr;
	}
	
	@DELETE
	@Path("cache")
	public String deleteCache() {
		System.out.println(">>> deleteCache");
		
		storeObjectsBean.deleteObjects(getUser());
		
		return getTree(ROOT_PATH);
	}

	@GET
	@Path("tree/{path:.*}")
	public String getTree(@PathParam("path") String path) {
		path = sanitize(path);
		System.out.println(">>> getTree: " + path);

		final User user = getUser();
		final StoreObject parent = storeObjectsBean.getStoreObject(user, path);

		System.out.println("\tParent: " + parent);

		List<StoreObject> folders = storeObjectsBean.getFolders(user, parent);
		if (folders == null || folders.size() == 0 && "/".equals(path)) {
			try {
				List<StorageObject> objects = listBucket(getCredential(request), user.getBucketName());
				if (objects != null) {
					for (StorageObject o : objects) {
						storeObjectsBean.create(user, o.getName(), o.getContentType(), 
								o.getUpdated().toStringRfc3339(), o.getSize().doubleValue());
					}
					folders = storeObjectsBean.getFolders(user, parent);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		//
		// Convert to DojoStore
		//
		
		Map<String, Object> parentRef = new HashMap<String, Object>();
		
		if (parent == null) {
			parentRef.put("id", "root");
			parentRef.put("name", "/");

			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (StoreObject o : folders) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", StoreObjectsBean.makeStoreObjectPublicId(user, o.getId()));
				map.put("name", o.getName());
				map.put("children", Boolean.TRUE);
				list.add(map);
			}
			
			parentRef.put("children", list);
			
		} else {
			parentRef.put("id", StoreObjectsBean.makeStoreObjectPublicId(user, parent.getId()));
			parentRef.put("name", parent.getName());
			
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			for (StoreObject o : folders) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", StoreObjectsBean.makeStoreObjectPublicId(user, o.getId()));
				map.put("name", o.getName());
				map.put("children", Boolean.TRUE);
				list.add(map);
			}
			
			parentRef.put("children", list);
		}
		
		return GSON.toJson(parentRef);
	}
	
	@PUT
	@Path("tree/{path:.*}")
	@Consumes("application/json")
	public String updateTree(@PathParam("path") String path, String jsonStr) {
		path = sanitize(path);
		System.out.println(">>> updateTree: " + path);
		System.out.println("\t" + jsonStr);
		
		final User user = getUser();
		
		@SuppressWarnings("unchecked")
		Map<String, Object> parentMap = GSON.fromJson(jsonStr, Map.class);
		System.out.println("parentMap: " + parentMap);
		
		String parentId = (String) parentMap.get("id");
		if ("root".equals(parentId)) {
			parentId = "";
		}

		final StoreObject parent = storeObjectsBean.getStoreObject(user, parentId);
		System.out.println("parent: " + parent);

		@SuppressWarnings("unchecked")
		List<Map<String, Object>> objectList = (List<Map<String, Object>>)parentMap.get("children");
		if (objectList != null) {
			for (Map<String, Object> objectMap : objectList) {
				String id = (String) objectMap.get("id");
				String name = (String) objectMap.get("name");
				String updated = (String) objectMap.get("updated");
				String contentType = (String) objectMap.get("contentType");
				Double size = (Double) objectMap.get("size");
				
				storeObjectsBean.update(StoreObjectsBean.makeStoreObjectId(user, id), name, updated, contentType, size, user, parent, true);
			}
		}

		return getTree(path);
	}

	private String sanitize(String path) {
		if (path != null && !path.equals(ROOT_PATH)) {
			if (!path.endsWith("/")) {
				path += "/";
			}
		} else {
			path = "/";
		}
		return path;
	}

	private User getUser() {
		User user = null;
		Principal principal = request.getUserPrincipal();
		if (principal != null) {
			user = usersBean.getUser(request.getUserPrincipal().getName());
		}
		return user;
	}
	
	//
	// OAuth2 calls
	//

	public static GoogleCredential getCredential(HttpServletRequest request) {
		String tokenData = (String) request.getSession().getAttribute("token");
		if (tokenData != null) {
			try {
				// Build credential from stored token data.
				GoogleCredential credential = new GoogleCredential.Builder()
						.setJsonFactory(JSON_FACTORY)
						.setTransport(TRANSPORT)
						.setClientSecrets(CLIENT_ID, CLIENT_SECRET).build()
						.setFromTokenResponse(JSON_FACTORY.fromString(
								tokenData, GoogleTokenResponse.class));

				return credential;

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	//
	// Google Store calls
	//

	public static List<StorageObject> listBucket(Credential credential, String bucketName) throws Exception {
		System.out.println(">>> listBucket: " + bucketName);
		
		Storage storage = getStorage(credential);

		List<StorageObject> objects = storage.objects().list(bucketName)
				.setFields("items(id,name,contentType,updated,size)")
				.setVersions(Boolean.FALSE)
				.execute().getItems();

		return objects;
	}

	private static Storage getStorage(Credential credential) {
		credential.getRefreshToken();
		return new Storage.Builder(TRANSPORT, JSON_FACTORY, credential)
				.setApplicationName("CloudFiles").build();
	}

}