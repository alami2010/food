/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { LeaveGuard } from './leaved/leaved.guard';
import { AuthGuard } from './guard/auth.guard';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { DefaultLayoutComponent } from './containers';
import { Page404Component } from './pages/auth/page404/page404.component';
import { Page500Component } from './pages/auth/page500/page500.component';
import { LoginComponent } from './pages/auth/login/login.component';
import { RegisterComponent } from './pages/auth/register/register.component';
import { SetupAuthGuard } from './setupGuard/auth.guard';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'dashboard',
    pathMatch: 'full'
  },
  {
    path: '',
    component: DefaultLayoutComponent,
    data: {
      title: 'Home'
    },
    children: [
      {
        path: 'pages',
        loadChildren: () =>
          import('./pages/auth/pages.module').then((m) => m.PagesModule)
      },
      {
        path: 'dashboard',
        loadChildren: () => import('./pages/dashboard/dashboard.module').then(m => m.DashboardModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'categories',
        loadChildren: () => import('./pages/categories/categories.module').then(m => m.CategoriesModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'cities',
        loadChildren: () => import('./pages/cities/cities.module').then(m => m.CitiesModule),
        canActivate: [AuthGuard]
      },

      {
        path: 'manage-users',
        loadChildren: () => import('./pages/manage-users/manage-users.module').then(m => m.ManageUsersModule),
        canActivate: [AuthGuard]
      },

      {
        path: 'users',
        loadChildren: () => import('./pages/users/users.module').then(m => m.UsersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'banners',
        loadChildren: () => import('./pages/banners/banners.module').then(m => m.BannersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'medias',
        loadChildren: () => import('./pages/medias/medias.module').then(m => m.MediasModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'app-pages',
        loadChildren: () => import('./pages/app-pages/app-pages.module').then(m => m.AppPagesModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'app-settings',
        loadChildren: () => import('./pages/app-settings/app-settings.module').then(m => m.AppSettingsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'general',
        loadChildren: () => import('./pages/general/general.module').then(m => m.GeneralModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'stores',
        loadChildren: () => import('./pages/stores/stores.module').then(m => m.StoresModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'manage-store',
        loadChildren: () => import('./pages/manage-stores/manage-stores.module').then(m => m.ManageStoresModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'referral',
        loadChildren: () => import('./pages/referral/referral.module').then(m => m.ReferralModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'offers',
        loadChildren: () => import('./pages/offers/offers.module').then(m => m.OffersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'drivers',
        loadChildren: () => import('./pages/drivers/drivers.module').then(m => m.DriversModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'blogs',
        loadChildren: () => import('./pages/blogs/blogs.module').then(m => m.BlogsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'blogs-details',
        loadChildren: () => import('./pages/blogs-details/blogs-details.module').then(m => m.BlogsDetailsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'payments',
        loadChildren: () => import('./pages/payments/payments.module').then(m => m.PaymentsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'foods',
        loadChildren: () => import('./pages/foods/foods.module').then(m => m.FoodsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'contact-forms',
        loadChildren: () => import('./pages/contact-forms/contact-forms.module').then(m => m.ContactFormsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'supports',
        loadChildren: () => import('./pages/supports/supports.module').then(m => m.SupportsModule),
        canActivate: [AuthGuard],
        canDeactivate: [LeaveGuard]
      },
      {
        path: 'complaints',
        loadChildren: () => import('./pages/complaints/complaints.module').then(m => m.ComplaintsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'address',
        loadChildren: () => import('./pages/address/address.module').then(m => m.AddressModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'administrator',
        loadChildren: () => import('./pages/administrator/administrator.module').then(m => m.AdministratorModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'notifications',
        loadChildren: () => import('./pages/notifications/notifications.module').then(m => m.NotificationsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'send-mail',
        loadChildren: () => import('./pages/send-mail/send-mail.module').then(m => m.SendMailModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'stats',
        loadChildren: () => import('./pages/stats/stats.module').then(m => m.StatsModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'orders',
        loadChildren: () => import('./pages/orders/orders.module').then(m => m.OrdersModule),
        canActivate: [AuthGuard]
      },
      {
        path: 'order-details',
        loadChildren: () => import('./pages/order-details/order-details.module').then(m => m.OrderDetailsModule),
        canActivate: [AuthGuard]
      }

    ]
  },
  {
    path: '404',
    component: Page404Component,
    data: {
      title: 'Page 404'
    }
  },
  {
    path: '500',
    component: Page500Component,
    data: {
      title: 'Page 500'
    }
  },
  {
    path: 'login',
    component: LoginComponent,
    data: {
      title: 'Login Page'
    },
    canActivate: [SetupAuthGuard]
  },
  {
    path: 'setup',
    component: RegisterComponent,
    data: {
      title: 'Register Page'
    },
  },
  {
    path: 'forgot',
    loadChildren: () => import('./pages/forgot/forgot.module').then(m => m.ForgotModule),
  },
  { path: '**', redirectTo: 'dashboard' }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      scrollPositionRestoration: 'top',
      anchorScrolling: 'enabled',
      initialNavigation: 'enabledBlocking',
      relativeLinkResolution: 'legacy',
      useHash: false
    })
  ],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
