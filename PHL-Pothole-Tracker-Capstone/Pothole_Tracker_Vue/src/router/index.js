import Vue from 'vue'
import Router from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import Logout from '../views/Logout.vue'
import Register from '../views/Register.vue'
import Test from '../views/Test.vue'
import Team from '../views/Team.vue'
import Blog from '../views/Blog.vue'
import ContactUs from '../views/ContactUs.vue'
import Dashboard from '../views/Dashboard.vue'
import ReportPothole from '../views/ReportPothole.vue'
import store from '../store/index'
import AnonDash from '../components/AnonDash.vue'
import UserDash from '../components/UserDash.vue'
import EmployeeDash from '../components/EmployeeDash.vue'
import UpdatePothole from '../views/UpdatePothole.vue'
import Claim from '../views/Claim.vue'
import PotholeDetails from '../components/PotholeDetails.vue'


Vue.use(Router)

/**
 * The Vue Router is used to "direct" the browser to render a specific view component
 * inside of App.vue depending on the URL.
 *
 * It also is used to detect whether or not a route requires the user to have first authenticated.
 * If the user has not yet authenticated (and needs to) they are redirected to /login
 * If they have (or don't need to) they're allowed to go about their way.
 */

const router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/login",
      name: "login",
      component: Login,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/logout",
      name: "logout",
      component: Logout,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/register",
      name: "register",
      component: Register,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/testing",
      name: "test",
      component: Test,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/team",
      name: "team",
      component: Team,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/blog",
      name: "blog",
      component: Blog,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/contact",
      name: "contact",
      component: ContactUs,
      meta: {
        requiresAuth: false
      }
    },
    {
      path: "/dashboard",
      name: "dashboard",
      component: Dashboard,
      meta: {
        requiresAuth: false
      },
      children: [
        {
          // TODO :: Fix routing to user report
          path: '',
          name: 'anon',
          component: AnonDash,
          meta: {
            requiresAuth: false,
          },
        },
        {
          path: 'user',
          name: 'user',
          component: UserDash,
          meta: {
            requiresAuth: true,
          },
        },
        {
          path: 'admin',
          name: 'admin',
          component: EmployeeDash,
          meta: {
            requiresAuth: true,
            
          }
        },
        {
          path: 'report',
          name: 'report',
          component: ReportPothole,
          meta: {
            requiresAuth: true,
          },
          beforeEnter:(to, from, next) =>{
              if(to.name=='report'){
                store.dispatch('setReportModeOn');
                next();
              }
          },

        },
        {
        path: 'update',
          name: 'update',
          component: UpdatePothole,
          meta: {
            requiresAuth: true,
          }
        },
        {
          path: 'details',
            name: 'details',
            component: PotholeDetails,
            meta: {
              requiresAuth: false,
            }
          },
        {
          path: 'claim',
          name: 'claim',
          component: Claim,
          meta: {
            requiresAuth: true,
          }
        },
        // {
        //   path: '*',
        //   component: Blog,
        //   meta: {
        //     requiresAuth: false,
        //   }
        // }
      ],
    }
  ]
})

router.beforeEach((to, from, next) => {
  // Determine if the route requires Authentication
  const requiresAuth = to.matched.some(x => x.meta.requiresAuth);

  // If it does and they are not logged in, send the user to "/login"
  if (requiresAuth && store.state.token === null) {
    next("/login");
  } else {
    // Else let them go to their next destination
    next();
  }
});

export default router;
