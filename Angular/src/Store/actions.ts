import {Injectable} from "@angular/core"
import { Action,  Selector, State, StateContext } from "@ngxs/store";
import { User } from "src/app/Model/User";

import {SetIsAuth,Logout,SetUser} from "./state"

export class AuthModel{
    isAuth:boolean=false;
    User:User | null | undefined;
}

@State<AuthModel>({
    name:'AuthStore',
    defaults:{
        isAuth:false,
        User:null
    }
})


@Injectable()
export class AuthStore{

    @Selector()
    static GetIsAuth({isAuth}:AuthModel){
        return isAuth;
    }

    @Selector()
    static getUser({User}:AuthModel){
        return User;
    }

    @Action(SetUser)
    SetUser({getState,patchState}:StateContext<AuthModel>,{data}:SetUser){
        patchState({
            User:data
        })
    }

    @Action(SetIsAuth)
    SetIsAuth({getState,patchState}:StateContext<AuthModel>,{data}:SetIsAuth){
        patchState({
            isAuth:data
        })
    }

    @Action(Logout)
    Logout({getState,patchState}:StateContext<AuthModel>){
        patchState({
            isAuth:false,
            User:null,
        })
    }

}