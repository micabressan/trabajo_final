// Questions:
// - BuildCommands looks like it works on subresources. That's deployments/rollback, deployments/scale, and so on. So does it not work on normal, non-sub resources? If so, what's the point? Do we want to be able to create subresources?

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"sync"

	"github.com/googleapis/gnostic/OpenAPIv2"
	"github.com/spf13/cobra"
	yaml "gopkg.in/yaml.v2"
	"k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/util/sets"
	"k8s.io/client-go/discovery"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/kube-openapi/pkg/util/proto"
	"k8s.io/kubernetes/pkg/kubectl/cmd/util/openapi"
)

func main() {
	builder := NewCmdBuilder()
	cmds, _ := builder.BuildCommands("create", "create", sets.NewString("create"))
	// fmt.Println(builder.getSubResources())
	// fmt.Println(cmds)
	for _, cmd := range cmds {
		fmt.Println(cmd.Use)
		// getCmd.AddCommand(cmd)
	}

	boop, err := builder.listResources()
	if err != nil {
		panic(err)
	}
	fmt.Println(boop)

}

func (builder *cmdBuilderImpl) listResources() ([]string, error) {
	s := []string{}
	gvs, err := builder.discovery.ServerResources()
	if err != nil {
		return nil, err
	}
	for _, gv := range gvs {
		// group, version := builder.groupVersion(gv.GroupVersion)
		for _, r := range gv.APIResources {
			s = append(s, r.Name)
		}
	}
	r := []string{}
	for _, i := range s {
		if !strings.Contains(i, "/") {
			var singular string
			switch {
			case strings.HasSuffix(i, "ies"):
				singular = i[0:len(i)-3] + "y"
			case strings.HasSuffix(i, "ses"):
				singular = i[0:len(i)-3] + "s"
			case strings.HasSuffix(i, "s"):
				singular = i[0 : len(i)-1]
			}
			r = append(r, singular)
		}
	}

	return r, nil
}

type CmdBuilder interface {
	BuildCommands(name, operation string, verbs sets.String) ([]*cobra.Command, error)
	listResources() ([]string, error)
}

// "read", "GET", sets.NewString("get")
func (builder *cmdBuilderImpl) BuildCommands(
	name string,
	requestType string,
	verbs sets.String) ([]*cobra.Command, error) {
	list, err := builder.getSubResources()
	// for a, b := range list {
	// 	fmt.Println(a)
	// 	for c, d := range b {
	// 		fmt.Println(c, d)
	// 	}
	// }
	if err != nil {
		panic(err)
	}

	// Setup a sub command for each operation
	parentCmds := map[string]*cobra.Command{}

	// fmt.Printf("Parents %+v\n", parentResources)
	for _, subResourceList := range list {
		resource := subResourceList[0]
		// If this subresource cannot be used as a cmd, continue
		if !builder.isCmd(&resource.resource) {
			continue
		}

		// Make sure it supports the verbs required for this command
		actualVerbs := sets.NewString(resource.resource.Verbs...)
		if len(actualVerbs.Intersection(verbs).List()) == 0 {
			continue
		}

		// Setup the command
		versions := []schema.GroupVersion{}
		for _, v := range subResourceList {
			versions = append(versions, v.apiGroupVersion)
		}
		cmd, err := builder.buildCmd(name, &resource.resource, versions)
		if err != nil {
			panic(err)
		}

		operation := builder.operation(&resource.resource)
		if _, found := parentCmds[operation]; !found {
			parentCmds[operation] = &cobra.Command{
				Use: fmt.Sprintf("%v", operation),
			}
		}
		parent := parentCmds[operation]
		parent.AddCommand(cmd)

		// Build the flags
		request, err := builder.buildFlags(cmd, resource)
		if err != nil {
			panic(err)
		}

		// Build the run function
		builder.buildRun(cmd, resource, request, requestType)
	}

	cmds := []*cobra.Command{}
	for _, cmd := range parentCmds {
		cmds = append(cmds, cmd)
	}

	return cmds, nil
}

type SubResource struct {
	resource                 v1.APIResource
	resourceGroupVersionKind schema.GroupVersionKind
	parent                   v1.APIResource
	apiGroupVersion          schema.GroupVersion
	openapiSchema            proto.Schema
}

func (builder *cmdBuilderImpl) getSubResources() (map[string][]*SubResource, error) {
	list := map[string][]*SubResource{}
	gvs, err := builder.discovery.ServerResources()
	if err != nil {
		return nil, err
	}

	parentResources := map[schema.GroupVersionResource]v1.APIResource{}

	// Index the parent resources by group,version,resource
	for _, gv := range gvs {
		group, version := builder.groupVersion(gv.GroupVersion)
		for _, r := range gv.APIResources {
			// fmt.Println(r.Name)
			if builder.isResource(&r) {
				parentResources[schema.GroupVersionResource{
					Group:    group,
					Version:  version,
					Resource: r.Name,
				}] = r
			}
		}
	}

	// Map subresources to resource names
	for _, gv := range gvs {
		group, version := builder.groupVersion(gv.GroupVersion)

		if len(builder.apiVersion) > 0 && builder.apiVersion != version {
			continue
		}

		for _, r := range gv.APIResources {
			if !builder.isSubResource(&r) {
				continue
			}

			// Sanity check - this shouldn't happen in practice
			if _, found := parentResources[getGVR(group, version, builder.resource(&r))]; !found {
				return nil, fmt.Errorf("Missing parent for subresource %s", r.Name)
			}

			// Set the group and version to the API groupVersion if missing
			if len(r.Group) == 0 {
				r.Group = group
			}
			if len(r.Version) == 0 {
				r.Version = version
			}

			gvk := schema.GroupVersionKind{
				r.Group,
				r.Version,
				r.Kind,
			}
			openapiSchema := builder.resources.LookupResource(gvk)
			if openapiSchema == nil {
				continue
			}

			// reassign variable so we can get a pointer to it
			sub := &SubResource{
				resource:                 r,
				resourceGroupVersionKind: schema.GroupVersionKind{r.Group, r.Version, r.Kind},
				parent:          parentResources[getGVR(group, version, builder.resource(&r))],
				apiGroupVersion: schema.GroupVersion{Group: group, Version: version},
				openapiSchema:   openapiSchema,
			}
			list[r.Name] = append(list[r.Name], sub)
		}
	}
	return list, nil
}

func NewCmdBuilder() CmdBuilder {
	return fwNewCmdBuilder(
		FactorySingleton.GetResources(),
		FactorySingleton.GetDiscovery(),
		FactorySingleton.GetRest(),
		FactorySingleton.GetApiGroup(),
		FactorySingleton.GetApiVersion(),
	)
}

// NewFlagBuilder returns a new request builder
func fwNewCmdBuilder(resources openapi.Resources,
	discovery discovery.DiscoveryInterface,
	rest rest.Interface,
	apiGroup, apiVersion string) CmdBuilder {
	return &cmdBuilderImpl{
		resources,
		discovery,
		rest,
		map[string]sets.String{},
		apiGroup,
		apiVersion,
	}
}

type cmdBuilderImpl struct {
	resources  openapi.Resources
	discovery  discovery.DiscoveryInterface
	rest       rest.Interface
	seen       map[string]sets.String
	apiGroup   string
	apiVersion string
}

func (builder *cmdBuilderImpl) buildCmd(name string, resource *v1.APIResource, versions []schema.GroupVersion) (*cobra.Command, error) {
	gvk := schema.GroupVersionKind{resource.Group, resource.Version, resource.Kind}
	if builder.resources.LookupResource(gvk) == nil {
		return nil, fmt.Errorf("No openapi definition found for %+v", gvk)
	}

	kind, operation, err := builder.resourceOperation(resource.Name)
	if err != nil {
		return nil, err
	}

	versionsList := []string{}
	d := false
	var group, version string
	for _, v := range versions {
		if !d {
			group = v.Group
			version = v.Version
			versionsList = append(versionsList, fmt.Sprintf("\t%s/%s (default)", v.Group, v.Version))
			d = true
		} else {
			versionsList = append(versionsList, fmt.Sprintf("\t%s/%s", v.Group, v.Version))
		}
	}

	cmd := &cobra.Command{
		Use: fmt.Sprintf("%v", kind),
		Example: fmt.Sprintf("kubecurl %s %s %s %s --name foo --api-group %s --api-version",
			name, operation, builder.resource(resource), group, version),
		Short: fmt.Sprintf("%s %s", operation, kind),
		Long: fmt.Sprintf(`Supported group/versions:
%s
`,
			strings.Join(versionsList, "\n")),
	}
	return cmd, nil
}

type Factory struct {
	sync.Once
	config        *rest.Config
	discovery     discovery.DiscoveryInterface
	resources     openapi.Resources
	openapischema *openapi_v2.Document
	rest          rest.Interface
	apiGroup      string
	apiVersion    string
}

var FactorySingleton = NewFactory()

func NewFactory() *Factory {
	f := &Factory{}
	f.inject()
	return f
}

// Hack to get around that we need to parse these flags before populating the flags that will be
// parsed by cobra - e.g. kubeconfig is needed to defined other flags which are based of the group and version
func getStringFlag(name, defaultVal string) string {
	found := false
	value := defaultVal
	for _, a := range os.Args {
		if found {
			value = a
			break
		}
		if strings.HasPrefix(a, "--") && strings.TrimPrefix(a, "--") == name {
			found = true
		}
	}
	return value
}

func (c *Factory) Version() (string, error) {
	v, err := c.discovery.ServerVersion()
	if err != nil {
		return "", err
	}

	switch v.Minor {
	case "7":
		return "1.7", nil
	case "8":
		return "1.8", nil
	default:
		return "", fmt.Errorf("server version unknown")

	}
}

func (c *Factory) inject() *rest.Config {
	c.Do(func() {
		flag.Parse()
		var kubeconfig string
		if home := homeDir(); home != "" {
			kubeconfig = getStringFlag("kubeconfig", filepath.Join(home, ".kube", "config"))
		} else {
			kubeconfig = getStringFlag("kubeconfig", "")
		}
		c.apiGroup = getStringFlag("api-group", "")
		c.apiVersion = getStringFlag("api-version", "")
		flag.Parse()

		// use the current context in kubeconfig
		config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
		if err != nil {
			panic(err.Error())
		}
		c.config = config

		clientset := kubernetes.NewForConfigOrDie(config)
		c.discovery = clientset.Discovery()

		openapischema, err := clientset.OpenAPISchema()
		if err != nil {
			panic(err.Error())
		}
		c.openapischema = openapischema

		resources, err := openapi.NewOpenAPIData(openapischema)
		if err != nil {
			panic(err.Error())
		}
		c.resources = resources

		c.rest = clientset.RESTClient()
	})
	return c.config
}

func (f *Factory) GetDiscovery() discovery.DiscoveryInterface {
	return f.discovery
}

func (f *Factory) GetResources() openapi.Resources {
	return f.resources
}

func (f *Factory) GetRest() rest.Interface {
	return f.rest
}

func (f *Factory) GetApiGroup() string {
	return f.apiGroup
}

func (f *Factory) GetApiVersion() string {
	return f.apiVersion
}

func (f *Factory) GetOpenapiSchema() *openapi_v2.Document {
	return f.openapischema
}

func homeDir() string {
	if h := os.Getenv("HOME"); h != "" {
		return h
	}
	return os.Getenv("USERPROFILE") // windows
}

func (builder *cmdBuilderImpl) isSubResource(resource *v1.APIResource) bool {
	if !strings.Contains(resource.Name, "/") {
		return false
	}
	if strings.HasSuffix(resource.Name, "/status") {
		return false
	}
	return true
}

func (builder *cmdBuilderImpl) isCmd(resource *v1.APIResource) bool {
	if !resource.Namespaced {
		return false
	}
	gvk := schema.GroupVersionKind{resource.Group, resource.Version, resource.Kind}
	return builder.resources.LookupResource(gvk) != nil
}

func (builder *cmdBuilderImpl) isResource(resource *v1.APIResource) bool {
	return !strings.Contains(resource.Name, "/")
}

func (builder *cmdBuilderImpl) setGroupVersionFromParentIfMissing(resource *v1.APIResource, parent *v1.APIResource) {
	if len(resource.Group) == 0 {
		resource.Group = parent.Group
	}
	if len(resource.Group) == 0 {
		resource.Group = "core"
	}
	if len(resource.Version) == 0 {
		resource.Version = parent.Version
	}
}

func (builder *cmdBuilderImpl) operation(resource *v1.APIResource) string {
	parts := strings.Split(resource.Name, "/")
	return parts[1]
}

func (builder *cmdBuilderImpl) resource(resource *v1.APIResource) string {
	parts := strings.Split(resource.Name, "/")
	return parts[0]
}

func (builder *cmdBuilderImpl) groupVersion(groupVersion string) (string, string) {
	parts := strings.Split(groupVersion, "/")
	var group, version string

	// Group maybe missing for apis under the "core" group
	if len(parts) > 1 {
		group = parts[0]
	} else {
		group = "core"
	}

	if len(parts) > 1 {
		version = parts[1]
	} else if len(parts) > 0 {
		version = parts[0]
	} else {
		version = "v1"
	}

	return group, version
}

func (builder *cmdBuilderImpl) resourceOperation(name string) (string, string, error) {
	parts := strings.Split(name, "/")
	if len(parts) < 2 {
		return "", "", fmt.Errorf("%s doesn't not match subresource name format", name)
	}
	return parts[0], parts[1], nil
}

func getGVR(group, version, resource string) schema.GroupVersionResource {
	return schema.GroupVersionResource{
		Group:    group,
		Version:  version,
		Resource: resource,
	}
}

// FlagBuilder returns a new request body parsed from flag values
func (builder *cmdBuilderImpl) buildFlags(cmd *cobra.Command, resource *SubResource) (map[string]interface{}, error) {
	gvk := schema.GroupVersionKind{
		resource.apiGroupVersion.Group,
		resource.apiGroupVersion.Version,
		resource.resource.Kind,
	}

	// Build a request body from flags
	visitor := newKindVisitor(cmd, gvk)
	resource.openapiSchema.Accept(visitor)
	return visitor.resource, nil
}

func newKindVisitor(cmd *cobra.Command, gvk schema.GroupVersionKind) *kindVisitor {
	resource := map[string]interface{}{}
	resource["apiVersion"] = fmt.Sprintf("%v/%v", gvk.Group, gvk.Version)
	resource["kind"] = fmt.Sprintf("%v", gvk.Kind)

	return &kindVisitor{
		emptyVisitor{},
		cmd,
		resource,
		map[string]*string{},
	}
}

type kindVisitor struct {
	emptyVisitor
	cmd         *cobra.Command
	resource    map[string]interface{}
	stringflags map[string]*string
}

func (v *kindVisitor) getRequest() interface{} {
	return v.resource
}

func (visitor *kindVisitor) VisitKind(k *proto.Kind) {
	visitor.stringflags["name"] = visitor.cmd.Flags().String("name", "", "name of the resource")
	visitor.stringflags["namespace"] = visitor.cmd.Flags().String("namespace", "default", "namespace of the resource")

	visitor.resource["metadata"] = map[string]interface{}{
		"name":      visitor.stringflags["name"],
		"namespace": visitor.stringflags["namespace"],
	}

	for k, v := range k.Fields {
		if blacklistedFields.Has(k) {
			continue
		}
		fv := visitor.newFieldVisitor(k)
		v.Accept(fv)
		if fv.field != nil {
			visitor.resource[k] = fv.field
		}
	}
}

func (v *kindVisitor) newFieldVisitor(name string) *fieldVisitor {
	return &fieldVisitor{
		v.emptyVisitor,
		name,
		v.cmd,
		map[string]interface{}{},
		false,
		v.stringflags,
	}
}

// fieldVisitor walks the openapi schema and registers flags for primitive fields
type fieldVisitor struct {
	emptyVisitor
	name        string
	cmd         *cobra.Command
	field       interface{}
	array       bool
	stringflags map[string]*string
}

var whitelistedFields = sets.NewString("spec", "rollbackTo")

// VisitKind recurses into certain fields to populate flags
func (visitor *fieldVisitor) VisitKind(k *proto.Kind) {
	// Only recurse for whitelisted fields
	if !whitelistedFields.HasAny(visitor.name) {
		return
	}

	// The result for a Kind is a map
	resource := map[string]interface{}{}
	visitor.field = resource

	for k, v := range k.Fields {
		fv := visitor.newFieldVisitor(k)
		v.Accept(fv)
		if fv.field != nil {
			resource[k] = fv.field
		}
	}
}

var blacklistedFields = sets.NewString("apiVersion", "kind", "metadata", "status")

// VisitPrimitive creates a new flag to populate the primitive value
func (visitor *fieldVisitor) VisitPrimitive(p *proto.Primitive) {
	// Never set flags for blacklisted fields
	if blacklistedFields.HasAny(visitor.name) {
		return
	}

	// Create a flag reference
	if !visitor.array {
		switch p.Type {
		case "integer":
			visitor.field = visitor.cmd.Flags().Int32(visitor.name, 0, p.Description)
		case "boolean":
			visitor.field = visitor.cmd.Flags().Bool(visitor.name, false, p.Description)
		case "string":
			if _, found := visitor.stringflags[visitor.name]; !found {
				visitor.stringflags[visitor.name] = visitor.cmd.Flags().String(visitor.name, "", p.Description)
			}
			visitor.field = visitor.stringflags[visitor.name]
		}
	} else {
		switch p.Type {
		case "integer":
			visitor.field = visitor.cmd.Flags().IntSlice(visitor.name, []int{}, p.Description)
		case "boolean":
			visitor.field = visitor.cmd.Flags().BoolSlice(visitor.name, []bool{}, p.Description)
		case "string":
			visitor.field = visitor.cmd.Flags().StringSlice(visitor.name, []string{}, p.Description)
		}
	}
}

func (visitor *fieldVisitor) VisitArray(p *proto.Array) {
	// Never set flags for blacklisted fields
	if blacklistedFields.HasAny(visitor.name) {
		return
	}

	fv := visitor.newFieldVisitor(visitor.name)
	fv.array = true
	p.SubType.Accept(fv)
	if fv.field != nil {
		visitor.field = fv.field
	}
}

func (*fieldVisitor) VisitMap(m *proto.Map) {
	// do nothing
}

// VisitReference traverses references
func (visitor *fieldVisitor) VisitReference(r proto.Reference) {
	r.SubSchema().Accept(visitor)
}

// newFieldVisitor creates a new fieldVisitor for recursion
func (v *fieldVisitor) newFieldVisitor(name string) *fieldVisitor {
	return &fieldVisitor{
		v.emptyVisitor,
		name,
		v.cmd,
		nil,
		false,
		v.stringflags,
	}
}

// emptyVisitor is a base implementation for composition that panics for all calls.
type emptyVisitor struct{}

func (*emptyVisitor) VisitArray(a *proto.Array) { panic(fmt.Errorf("Unexpected array call %+v", a)) }
func (*emptyVisitor) VisitMap(m *proto.Map)     { panic(fmt.Errorf("Unexpected map call %+v", m)) }
func (*emptyVisitor) VisitPrimitive(p *proto.Primitive) {
	panic(fmt.Errorf("Unexpected primitive call %+v", p))
}
func (*emptyVisitor) VisitKind(k *proto.Kind) { panic(fmt.Errorf("Unexpected kind call %+v", k)) }
func (*emptyVisitor) VisitReference(r proto.Reference) {
	panic(fmt.Errorf("Unexpected reference call %+v", r))
}

func (builder *cmdBuilderImpl) buildRun(cmd *cobra.Command, resource *SubResource, request map[string]interface{},
	requestType string) {

	cmd.Run = func(cmd *cobra.Command, args []string) {

		out, _ := json.Marshal(request)
		// Pull the name and namespace from the request so they are added to the url path
		meta := request["metadata"].(map[string]interface{})
		name := meta["name"].(*string)
		namespace := meta["namespace"].(*string)

		// Create the request

		var result *rest.Request

		verbs := sets.NewString(resource.resource.Verbs...)
		switch requestType {
		case "PUT":
			if verbs.HasAny("create") {
				result = builder.rest.Post()
			} else if verbs.HasAny("update") {
				result = builder.rest.Put()
			} else {
				panic(fmt.Errorf("requestType %v not supported by verbs %v", requestType, resource.resource.Verbs))
			}
		case "GET":
			if verbs.HasAny("get") {
				result = builder.rest.Get()
			} else {
				panic(fmt.Errorf("requestType %v not supported by verbs %v", requestType, resource.resource.Verbs))
			}
		default:
			panic(fmt.Errorf("requestType %v not supported", requestType))
		}

		var prefix []string
		if resource.apiGroupVersion.Group == "core" {
			prefix = []string{"api", resource.apiGroupVersion.Version}
		} else {
			prefix = []string{"apis", resource.apiGroupVersion.Group, resource.apiGroupVersion.Version}
		}

		result = result.
			Prefix(prefix...).
			Namespace(*namespace).
			Resource(builder.resource(&resource.resource)).
			SubResource(builder.operation(&resource.resource)).
			Name(*name).
			Body(out)

		resp, err := result.DoRaw()
		if err != nil {
			fmt.Printf("URL: %s\n", result.URL().Path)
			fmt.Printf("Error: %v\n", err)
			fmt.Printf("RequestBody: %s\n", out)
			fmt.Printf("ReponseBody: %s\n", resp)
			return
		}

		mapResp := &map[string]interface{}{}
		err = json.Unmarshal(resp, mapResp)
		if err != nil {
			fmt.Printf("Error unmarshalling json map from bytes: %v %s\n", err, resp)
		}

		resp, err = yaml.Marshal(mapResp)
		if err != nil {
			fmt.Printf("Error marshalling yaml bytes from map: %v %v\n", mapResp, err)
		}
		fmt.Printf("%s", resp)
	}
}