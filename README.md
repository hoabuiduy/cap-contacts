# cap-contacts

Get contact list from the device

## Install

```bash
npm install cap-contacts
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`getContacts(...)`](#getcontacts)
* [`pickContact()`](#pickcontact)
* [`checkPermission()`](#checkpermission)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### getContacts(...)

```typescript
getContacts(options: { name: string; }) => any
```

| Param         | Type                           |
| ------------- | ------------------------------ |
| **`options`** | <code>{ name: string; }</code> |

**Returns:** <code>any</code>

--------------------


### pickContact()

```typescript
pickContact() => any
```

**Returns:** <code>any</code>

--------------------


### checkPermission()

```typescript
checkPermission() => any
```

**Returns:** <code>any</code>

--------------------


### Interfaces


#### ContactDetail

| Prop        | Type                |
| ----------- | ------------------- |
| **`name`**  | <code>string</code> |
| **`phone`** | <code>string</code> |

</docgen-api>
