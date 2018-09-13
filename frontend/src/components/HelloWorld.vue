<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <h2 v-if="users.length">Users</h2>
    <div v-for="user in users" :key="user.id">
      {{ user.id }}: {{ user.name }}
    </div>
    <button v-if="users.length" @click="clear">clear</button>
    <button v-if="!users.length" @click="load">load</button>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data: function() {
    return { 'users': [] };
  },
  props: {
    msg: String
  },
  created: function() { this.load(); },
  methods: {
    load: function(){
      var vm = this;
      vm.axios.get('/api/users')
        .then(
          function(res) { vm.users = res.data; }
        );
      },
    clear: function(){this.users = []}
  }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
