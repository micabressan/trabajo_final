@RequestMapping(method = RequestMethod.POST, value = "/make/")
    public Boolean createUser(@RequestBody User user) {
        try {
            userRepository.save(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }