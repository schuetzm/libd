module d.ast.adt;

import d.ast.base;
import d.ast.declaration;
import d.ast.dscope;
import d.ast.expression;
import d.ast.identifier;
import d.ast.type;

/**
 * Class Definition
 */
class ClassDefinition : Declaration {
	string name;
	Identifier[] bases;
	Declaration[] members;
	
	this(Location location, string name, Identifier[] bases, Declaration[] members) {
		super(location);
		
		this.name = name;
		this.bases = bases;
		this.members = members;
	}
}

/**
 * Interface Definition
 */
class InterfaceDefinition : Declaration {
	string name;
	Identifier[] bases;
	Declaration[] members;
	
	this(Location location, string name, Identifier[] bases, Declaration[] members) {
		super(location);
		
		this.name = name;
		this.bases = bases;
		this.members = members;
	}
}

/**
 * Struct Declaration
 */
class StructDeclaration : Symbol {
	this(Location location, string name) {
		super(location, name);
	}
}

/**
 * Struct Definition
 */
class StructDefinition : StructDeclaration {
	Declaration[] members;
	
	class StructType : BasicType {
		Type[] members;
	
		this(Location location) {
			super(location);
		}
	
		override Expression initExpression(Location location) {
			// FIXME: return the proper init.
			return new VoidInitializer(location, this);
		}
		
		override Namespace resolve(Location location, string name) {
			return dscope.resolve(location, name);
		}
	}
	
	StructType type;
	
	Scope dscope;
	
	this(Location location, string name, Declaration[] members) {
		super(location, name);
		
		this.members = members;
		
		type = new StructType(location);
	}
	
	override Namespace resolve(Location location, string name) {
		return dscope.resolve(location, name);
	}
}

/**
 * Union Declaration
 */
class UnionDeclaration : Declaration {
	string name;
	
	this(Location location, string name) {
		super(location);
		
		this.name = name;
	}
}

/**
 * Union Definition
 */
class UnionDefinition : UnionDeclaration {
	Declaration[] members;
	
	this(Location location, string name, Declaration[] members) {
		super(location, name);
		
		this.members = members;
	}
}

/**
 * Enum
 */
class Enum : Declaration {
	VariablesDeclaration enumEntries;
	Type type;
	
	this(Location location, Type type, VariablesDeclaration enumEntries) {
		super(location);
		
		this.enumEntries = enumEntries;
	}
}

/**
 * Named enum
 */
class NamedEnum : Enum {
	string name;
	
	this(Location location, string name, Type type, VariablesDeclaration enumEntries) {
		super(location, type, enumEntries);
		
		this.name = name;
	}
}

